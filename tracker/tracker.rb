require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'

module Ravana
  module Data
    # The torrents that exist.
    def load_torrents
      query = "select info_hash from torrents"
    end

    # The allowed groups of people.
    def load_whitelist
      query = "select peer_id from users"
    end
  end

  class TorrentTracker < EM::Connection
    include EM::HttpServer

    module Announce
      def request_handler
        response = EM::DelegatedHttpResponse.new(self)
        response.status = 200
        response.content_type 'text/html'
        response.content = '<center><h1>Hi asd asd asd asd</h1></center>'
        response.send_response
      end
    end

    module Scrape
      def request_handler
        response = EM::DelegatedHttpResponse.new(self)
        response.status = 200
        response.content_type 'text/html'
        response.content = '<center><h1>Hi asd</h1></center>'
        response.send_response
      end
    end

    def post_init
      super
      no_environment_strings
    end

    def process_http_request
      # the http request details are available via the following instance variables:
      #   @http_protocol
      #   @http_request_method
      #   @http_cookie
      #   @http_if_none_match
      #   @http_content_type
      #   @http_path_info
      #   @http_request_uri
      #   @http_query_string
      #   @http_post_content
      #   @http_headers

      case @http_request_uri
      when "/announce"
        ::Announce.request_handler
      when "/scrape"
        ::Scrape.request_handler
      end
    end
  end
end

EventMachine::run {
  EventMachine::start_server "127.0.0.1", 8081, Ravana::TorrentTracker
}

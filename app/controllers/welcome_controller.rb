≈class WelcomeController < ApplicationController

  before_filter do
    redirect_to latest_path if user_signed_in?
  end

  def index
  end

  def invite
  end
end

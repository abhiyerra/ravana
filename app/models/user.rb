require 'digest/sha1'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :client_applications
  has_many :tokens, 
           :class_name => "OauthToken",
           :order      => "authorized_at desc",
           :include    => [ :client_application ]

  # Create the user refcode.
  before_create do
    self.ref_code = Digest::SHA1.hexdigest("#{Time.now.to_s}#{self.email}")
  end

  has_many :torrents

  has_many :indexer_peers

  # TODO: Fill this in with PGP based checks.
  def trust_level
    0
  end

  def total_upload
    500.0
  end

  def total_download
    0.0
  end

  def ratio
    0.0
  end

  def required_ratio
    0.0
  end
end

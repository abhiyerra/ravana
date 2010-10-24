class Category < ActiveRecord::Base
  has_many :torrents

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
end

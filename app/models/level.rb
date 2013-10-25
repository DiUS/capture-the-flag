class Level < ActiveRecord::Base
  has_many :games

  validates_presence_of :name, :source_url, :description
end

require 'game_ec2'
class Game < ActiveRecord::Base

  belongs_to :user
  belongs_to :level

  validates_presence_of :user, :level

  def self.create_ec2_game
    aws_access_key = "AKIAIVESJITWA4YPMAYA"
    aws_secret_access = "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"
    region = "ap-southeast-2"
    game_ec2 = GameEc2.new
    game_instance = game_ec2.create_game()
  end

  def self.get_game_instance_status(instance)
    game_ec2 = GameEc2.new
    game_instance = game_ec2.get_game_instance(instance)
  end
end

require 'game_ec2'
class Game < ActiveRecord::Base

  belongs_to :user
  belongs_to :level

  validates_presence_of :user, :level

  def capture_code_correct?
    self.capture_code == self.level.capture_code
  end

  def self.create_ec2_game
    game_ec2 = GameEc2.new
    game_instance = game_ec2.create_game(source_url)
  end

  def self.get_game_instance_status(instance)
    game_ec2 = GameEc2.new
    game_instance = game_ec2.get_game_instance(instance)
  end
end

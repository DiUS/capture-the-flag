class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def create
    ec2_game = Game.create_ec2_game
    Game.create :url => ec2_game.public_dns_name
    redirect :to => 'index'
  end
end

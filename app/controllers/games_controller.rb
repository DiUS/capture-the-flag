class GamesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @game.level = Level.find(params[:level_id])
    @game.user = current_user
  end

  def create
    # ec2_game = Game.create_ec2_game
    # Game.create :url => ec2_game.public_dns_name
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      flash[:notice] = "Your game will be started soon..."
      redirect_to action: 'index'
    else
      flash[:error] = @level.errors.full_messages.to_sentence
      render 'new'
    end
  end


  private

  def set_game
    @level = Game.find(params[:id])
  end

  def game_params
    params.permit(:level_id)
  end

end

class GamesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy, :verify]

  def index
    update_ec2_statuses
    @games = Game.all
  end

  def new
    @game = Game.new
    @game.level = Level.find(params[:level_id])
    @game.user = current_user
  end

  def verify
    original_capture_code = @game.capture_code
    @game.update_attributes(game_params)
    if original_capture_code != @game.capture_code && !@game.captured
      @game.captured = @game.capture_code_correct?
      puts "*********** #{@game.level.capture_code}"
      @game.save
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    # ec2_game = Game.create_ec2_game
    # Game.create :url => ec2_game.public_dns_name
    # options = {:instance_status => "Pending", instance_id => ec2_game.instance_id}
    @game = Game.new
    @game.level = Level.find(params[:level_id])
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

  def update_ec2_statuses
    Game.all.each do |g|
      ec2_instance = Game.get_game_instance_status(g.instance_id)
      g.url = ec2_instance.first[1].first.instances_set[0].dns_name
      g.instance_status = ec2_instance.first[1].first.instances_set[0].instance_state.name.capitalize
      g.save!
    end
  end

  def game_params
    params.require(:game).permit(:capture_code)
  end

end

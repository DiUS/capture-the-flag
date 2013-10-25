class LevelsController < ApplicationController
  before_action :set_level, only: [:show, :edit, :update, :destroy]

  def index
    @levels = Level.all
  end

  def new
    @level = Level.new
  end

  def create
    @level = Level.new(level_params)
    if @level.save
      flash[:notice] = "Level created"
      redirect_to action: 'index'
    else
      flash[:error] = @level.errors.full_messages.to_sentence
      render 'new'
    end
  end


  private

  def set_level
    @level = Level.find(params[:id])
  end

  def level_params
    params.require(:level).permit(:name, :source_url, :description)
  end
end

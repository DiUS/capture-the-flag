class LevelsController < ApplicationController
	def index
		@levels = Level.all
	end

	def create
		
	end
end

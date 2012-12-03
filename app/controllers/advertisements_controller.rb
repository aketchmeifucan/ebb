class AdvertisementsController < ApplicationController
	def show
		@advertisement = Advertisement.find(params[:id])
	end

	def new
		@board = Board.find(params[:board_id])
		#		@advertisement = Board.find(params[:board_id]).advertisements.new
		@advertisement = Advertisement.new
	end

	def create
		#		#build vs create?!!!
		#		@advertisement = Board.find(params[:board_id]).advertisements.build(params[:advertisement])
		#		@board = Board.find(params[:board_id])
		@board = Board.find(params[:board_id])
		@advertisement = @board.advertisements.build(params[:advertisement])
		@advertisement.user = current_user
		if @advertisement.save
			flash[:success] = "Advertisement created"
			redirect_to @board
		else
			render 'new'
		end
	end

	def destroy
		Advertisement.find(params[:id]).destroy
		flash[:success] = "Advertisement destroyed."
	end

	def index
		@advertisements = Advertisement.all
	end
end

class BoardsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]
	def show
		@board = Board.find(params[:id])
	end

	def new
		@board = Board.new
		#need to redirect at all?? if not signed in?
	end

	def create
		#create instead of build?? mass assignment user not accessible
		@board = current_user.boards.create(params[:board])
		if @board.save
			flash[:success] = "Board created!"
			redirect_to @board
			#success msg!
		else
			render 'new'
			#this right?
		end
		#need to redirect if signed in??
	end

	def destroy
		Board.find(params[:id]).destroy
		flash[:success] = "Board destroyed."
		#redirect to boards_url??
	end

	def index
		@boards = Board.all
	end
end

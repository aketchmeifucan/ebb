class BoardsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]

	def show
		@board = Board.find(params[:id])
		@advertisements = @board.advertisements
	end

	def new
		@board = current_user.boards.build
		#need to redirect at all?? if not signed in?
	end

	def create
		#create instead of build?? mass assignment user not accessible
		@board = current_user.boards.build(params[:board])
		#add default or fake ad...doesn't matter how big...so assets/rails.png??
		if @board.save
			flash[:success] = "Board created!"
			redirect_to @board
			#success msg!
		else
			render 'new'
			#this right?
		end
	end

	def destroy
		Board.find(params[:id]).destroy
		flash[:success] = "Board destroyed."
		#redirect to boards_url??
	end

	def index
		@boards = Board.all
	end

	private
	def signed_in_user
		unless signed_in?
			store_location
#			redirect_to root_path, notice: "Not signed in."
			redirect_to(root_path, flash: {error: "Not signed in"})
#			redirect_to(root_path)
#			flash[:error] = "Not signed in"
		end
	end
end

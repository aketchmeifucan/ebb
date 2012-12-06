class AdvertisementsController < ApplicationController
	before_filter signed_in_user, only: [:new, :create]
	
	def show
		@advertisement = Advertisement.find(params[:id])
	end

	def new
		@board = Board.find(params[:board_id])
		#		@advertisement = Board.find(params[:board_id]).advertisements.new
		@advertisement = Advertisement.new
	end

	def create
		#build vs create?!!!
		@board = Board.find(params[:board_id])
    	# @advertisement = Board.find(params[:board_id]).advertisements.build(params[:advertisement])
		@advertisement = @board.advertisements.build(params[:advertisement])
#		@advertisement.image = image_contents=(@advertisement.image)
		@advertisement.user = current_user
		for c in @advertisement.x_location..(@advertisement.width + @advertisement.x_location)
			for r in @advertisement.y_location..(@advertisement.height + @advertisement.y_location)
#				@t = @advertisement.tiles.build(x_location: c, y_location: r)
#				#CHANGE COST function maybe @board.tiles.find(x_location, y_location)??????
#				@t.cost = 2
#				@t.save
			end
		end
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

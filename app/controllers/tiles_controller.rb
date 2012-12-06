class TilesController < ApplicationController
	def show
		@tile = Tile.find(params[:id])
	end

	def new
		@advertisement = Advertisement.find(params[:advertisement_id])
		@board = @advertisement.board
		@tile = @advertisement.tiles.build
	end

	def create
		@advertisement = Advertisement.find(params[:advertisement_id])
		@board = @advertisement.board
		@tile = @advertisement.tiles.build(params[:tile])
		#does tile cost need to be assigned separately? 
		if @tile.save
			flash[:success] = "Tile created"
			redirect to @advertisement
		else
			render 'new'
		end
	end

	def destroy
		Tile.find(params[:id]).destroy
		flash[:success] = "Tile destroyed"
	end

	def index
		@advertisement = Advertisement.find(params[:advertisement_id])
		@tiles = @advertisement.tiles
	end
end

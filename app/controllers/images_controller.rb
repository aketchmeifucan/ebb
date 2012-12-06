class ImagesController < ApplicationController
	def show
		@advertisement = Advertisement.find(params[:id])
#		render :text => open(@advertisement.image, "rb").read
#		render(text: @advertisement.image, content_type: "image/jpeg")
#		send_data File.read(@advertisement.image), :type = "image/jpeg", :disposition => "inline"
#		File.open(@advertisement.image, 'rb') do |f|
#			send_data f.read, :type => "image/jpeg", :disposition => "inlin"
#		end
		send_data(@advertisement.image, :disposition => 'inline')
	end
end

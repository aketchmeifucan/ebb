class SessionsController < ApplicationController
	def new
	end

	def create 
#		user = User.find_by_email(params[:session][:email].downcase)
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
#		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
#			redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
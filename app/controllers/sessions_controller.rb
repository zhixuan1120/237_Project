class SessionsController < ApplicationController

	def new
		if signed_in?
			@feed_items = current_user.feed.paginate(page: params[:page])
			redirect_to root_path
		end
	end

	def create
	  	user = User.find_by_email(params[:email])
	  	if !user.nil?
	  		if user.confirmed?	  		
	  			if user && user.authenticate(params[:password])
	  				sign_in user
	  				redirect_back_or root_path
	  			else
	  				flash.now[:error] = 'Invalid email/password combination'
	  				render 'new'
	  			end
	  		else
	  			flash.now[:error] = 'Please activate your account through email'
	  			render 'new'
	  		end
	  	else
	  		flash.now[:error] = "We do not recognise your email, pleas sign up first"
	  		render 'new'
	  	end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
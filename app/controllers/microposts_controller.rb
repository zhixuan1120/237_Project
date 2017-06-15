class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :index]
	before_action :correct_user, only: :destroy

	def create

		if !params[:micropost][:email].empty? && !params[:micropost][:tag].empty?
			# if this message is sent to a specific person

			@user = User.where("email = ?", params[:micropost][:email]).first

			if !@user.nil?
				# Find all receiver's microposts.
				@receiver_posts = Micropost.where("user_id = ?", @user[:id])
		
				# Find all the microposts which receiver wants to send to sender.
				@match_posts = @receiver_posts.where("email = ?", current_user.email)
		
				#Find the final micropost which will be sent to sender. 
				@final_post = @match_posts.where(["tag = ?", params[:micropost][:tag]]).first
			end
		end
		
		@micropost = current_user.microposts.build(micropost_params)

		@micropost[:sender_email] = current_user.email
		
		# We find some match post
		if !@final_post.nil?
			MicropostMailer.find_match(@user, current_user, @micropost).deliver
			MicropostMailer.find_match(current_user, @user, @final_post).deliver
			
			@final_post.update_attribute(:match, true)
			@micropost.update_attribute(:match, true)
		end

		if @micropost.save
			if params[:micropost][:email].empty?
				@post = @micropost
			else
				@post = nil
			end
			flash.now[:notice] = "Message sent successfully."
		else 
			flash.now[:notice] = "Message sent unsuccessfully. Please try again."
		end
	end

	def index 
		@mails = Micropost.where("email = ? and match IS TRUE", current_user.email)
		render 'microposts/inbox'
	end 

	def destroy
		@matched_receiver = User.where("email = ?", @micropost[:email]).first
		if !@matched_receiver.nil?
			@matched_receiver_posts = Micropost.where("user_id = ?", @matched_receiver[:id])
			@matched_posts = @matched_receiver_posts.where("email = ?", current_user.email)
			@final_matched_post = @matched_posts.where("tag = ?", @micropost[:tag]).first
			@final_matched_post.update_attribute(:match, false) if !@final_matched_post.nil?
		end
		@micropost.destroy
		redirect_to current_user
	end

	# In this funtion, you should use current_user.microposts.build, instead of current_user.microposts.new,
	# even though new and build have the same functionality. 
	# current_user.microposts.new will cause stack overflow due to infinite recursion because the method name is also "new".
	def new
    	@feed_items = Micropost.where("email = ''").page(params[:page]).per_page(15)
    	@micropost = current_user.microposts.build
    	@user = current_user
  	end

	def mark_as_read
		@read_notification = Micropost.where("id = ?", params[:id])
		@read_notification.update_attribute(:read, true)
	end

	def vote
		# new(attributes = nil, options = {})
		# e.g. Instantiate a single object by passing mass-assignment security
		# User.new({ :first_name => 'Jamie', :is_admin => true }, :without_protection => true)

    	@vote = current_user.votes.new(value: params[:value], micropost_id: params[:id])
        @vote.save
        @count = params[:count].to_i + params[:value].to_i
  	end

  	def delete
  		vote = Vote.where("micropost_id = ? and user_id = ?", params[:id], current_user.id).first
  		@count_delete = params[:count].to_i - vote.value.to_i
  		@micropost = Micropost.where("id = ?", params[:id]).first
  		vote.destroy
  	end
  	
	private
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_path if @micropost.nil?
		end

  		# Action Controller parameters are forbidden to be used in Active Model mass assignments 
  		# until they have been whitelisted.
  		def micropost_params
    		params.require(:micropost).permit(:content, :user_id, :email, :tag)
  		end
end


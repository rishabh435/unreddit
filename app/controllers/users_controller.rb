class UsersController < ApplicationController
	def new
	end

	def create
		user = User.new(user_params)
	    if user.save
	      session[:user_id] = user.id
	      redirect_to '/'
	    else
	    	flash[:error] = user.errors.full_messages.to_sentence
	    #   user.errors.full_messages.each_with_index do |message,index|
    	# 	flash[:index] = message
 		  # end
 		  p flash	
	      redirect_to '/signup'
	    end
	end 

	def show
		@posts = Post.where(user_id: session[:user_id])
		@comments = Comment.where(user_id: session[:user_id])
		@subscriptions = Subscriber.where(user_id: session[:user_id])
		@activity_feed = @posts + @comments + @subscriptions
		@activity_feed.sort_by!(&:created_at)
		
	end  
	private

	  def user_params
	    params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end

end

class SubscribersController < ApplicationController

  def create
    if @subscriber = Subscriber.find_by(subreddit_id: params[:subreddit_id], user_id: params[:user_id])
      @subscriber.destroy
    else
      @subscriber = Subscriber.find_or_create_by(subreddit_id: params[:subreddit_id], user_id: params[:user_id])
    end

    @sub_val = params[:sub_val]

    respond_to do |format|
      if @subscriber.save
        @subscriber_count = Subscriber.where(subreddit_id:params[:subreddit_id]).count
        format.js { render 'create.js.erb' }
      else
        format.html { redirect_to @subscriber}
        format.js do
          render js: "alert('There are empty fields in the form!');"
        end
      end
    end
  end
end

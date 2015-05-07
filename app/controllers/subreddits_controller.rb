class SubredditsController < ApplicationController
  def index
    @subreddits = Subreddit.all
  end
  def new
  end
  def create
    @subreddit = Subreddit.new(title: params[:subreddit_title].downcase)
    respond_to do |format|
      if @subreddit.save
        format.js { render 'create.js.erb' }
      else
      	@error = @subreddit.errors.full_messages.to_sentence
        format.js { render 'error.js.erb' }
      end
    end
  end
  def show
    @subreddit = Subreddit.find(params[:id])
    session[:subreddit_id] = params[:id]
    @subscriber_count = Subscriber.where(subreddit_id: params[:id]).count
    pids = Post.where(subreddit_id: params[:id]).map { |p| p.id}
    @vote_count_arr = pids.map { |pid| PostVote.where(post_id: pid).inject(0) {|sum,pv| sum+pv.vote_val}}
    @posts = Post.where(subreddit_id: params[:id])
  end

end

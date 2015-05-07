class RedditController < ApplicationController
  def index
  	session.delete(:subreddit_id)
		subscribed_subreddit_ids = Subscriber.where(user_id: session[:user_id]).map {|subscriber| subscriber.subreddit_id}
		@posts = subscribed_subreddit_ids.map { |s| Post.where(subreddit_id: s)}.flatten
		@posts += Post.all - @posts
		@posts = @posts.paginate(page: params[:page], per_page: 5)
		@vote_count_arr = @posts.map { |p| PostVote.where(post_id: p.id).inject(0) {|sum,pv| sum+pv.vote_val}}
		@post_subreddit = @posts.map { |p| Subreddit.find(p.subreddit_id)}
		
  end
end

class PostVotesController < ApplicationController
	def create
		if (params[:type] == 'voteup')
			post_vote = PostVote.find_or_create_by(post_id: params[:post_id], user_id:session[:user_id])
			if post_vote.vote_val == 1
				post_vote.vote_val = 0
			else
				post_vote.vote_val = 1
			end
			@post_id = params[:post_id]
		elsif (params[:type] == 'votedown')
			post_vote = PostVote.find_or_create_by(post_id: params[:post_id],user_id:session[:user_id])
			if post_vote.vote_val == -1
				post_vote.vote_val = 0
			else
				post_vote.vote_val = -1
			end
			@post_id = params[:post_id]
		end
		respond_to do |format|
			if post_vote.save
				@vote_count = PostVote.where(post_id:params[:post_id]).inject(0) {|sum,pv| sum+pv.vote_val }
				format.js { render 'create.js.erb' }
			else
				format.html { redirect_to post_vote}
				format.js do
					render js: "alert('There are empty fields in the form!');"
				end
			end
		end
	end
end

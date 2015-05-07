class CommentVotesController < ApplicationController
	def create
		if (params[:type] == 'voteup')
			comment_vote = CommentVote.find_or_create_by(comment_id: params[:comment_id], user_id:session[:user_id])
			if comment_vote.vote_val == 1
				comment_vote.vote_val = 0
			else
				comment_vote.vote_val = 1
			end
			@comment_id = params[:comment_id]
		elsif (params[:type] == 'votedown')
			comment_vote = CommentVote.find_or_create_by(comment_id: params[:comment_id],user_id:session[:user_id])
			if comment_vote.vote_val == -1
				comment_vote.vote_val = 0
			else
				comment_vote.vote_val = -1
			end
			@comment_id = params[:comment_id]
		end
		respond_to do |format|
			if comment_vote.save
				@vote_count = CommentVote.where(comment_id:params[:comment_id]).inject(0) {|sum,pv| sum+pv.vote_val }
				format.js { render 'create.js.erb' }
			else
				format.html { redirect_to comment_vote}
				format.js do
					render js: "alert('There are empty fields in the form!');"
				end
			end
		end
	end
end

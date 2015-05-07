class CommentsController < ApplicationController
  def create
  	@comment = Comment.new(comment_params)
  	@comment.user_id = session[:user_id]
  	@comment.post_id = params[:post_id]
  	@post = Post.find(params[:post_id])
  	if @comment.save
  		redirect_to post_path(@post)
  	else
  		redirect_to post_path(@post)
  	end
  end

  private
  def comment_params
    params.require(:comments).permit(:content)
  end
end

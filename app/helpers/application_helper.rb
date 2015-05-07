module ApplicationHelper
  def vote_state(vote_val)
    vote_class = {}
    if vote_val == 0 || vote_val == nil
      vote_class["up"] = 'in-active'
      vote_class["down"] = 'in-active'
    elsif vote_val == 1
      vote_class["up"] = ''
      vote_class["down"] = 'in-active'
    elsif vote_val == -1
      vote_class["up"] = 'in-active'
      vote_class["down"] = ''
    end
    return vote_class
  end

  def find_comment_vote_val(comment_id, user_id)
    if CommentVote.exists?(comment_id: comment_id, user_id: user_id)
      return CommentVote.find_by(comment_id: comment_id, user_id: user_id).vote_val 
    else
      return 0
    end
  end

  def find_post_vote_val(post_id, user_id)
    if PostVote.exists?(post_id: post_id, user_id: user_id)
      return PostVote.find_by(post_id: post_id, user_id: user_id).vote_val 
    else
      return 0
    end
  end

  def get_user_post_count(user_id)
    Post.where(user_id: user_id).where.not(content: nil).count
  end
  def get_user_link_count(user_id)
    Post.where(user_id: user_id).where.not(link: nil).count
  end
  def get_user_comment_count(user_id)
    Comment.where(user_id: session[:user_id]).count
  end
  def get_image(link)
    LinkThumbnailer.generate(link).images.first.src.to_s
  end
end

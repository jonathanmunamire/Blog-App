class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:text).merge(author_id: current_user.id, post_id: post.id))

    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(current_user, post)
        else
          redirect_to new_user_post_comment_path(current_user)
        end
      end
    end
  end
end

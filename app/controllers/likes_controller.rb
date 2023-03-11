class LikesController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new
    @like.post = @post

    if @like.save
      flash[:success] = 'Post liked successfully'
      redirect_to user_post_path(@post.author_id, @post)
    else
      flash[:error] = 'Error: Post could not be liked'
      render :new
    end
  end
end

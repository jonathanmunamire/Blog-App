class PostsController < ApplicationController
  def index
    @user = User.includes(:posts, posts: [:comments]).find(params[:user_id])
  end

  def show
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text).merge(author_id: current_user.id, comments_counter: 0,
                                                                       likes_counter: 0))

    respond_to do |format|
      format.html do
        if @post.save
          redirect_to user_post_path(current_user, @post)
        else
          redirect_to new_user_post_path(current_user)
        end
      end
    end
  end
end

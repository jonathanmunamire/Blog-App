class Api::V1::PostsController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @posts = @user.posts.includes(:comments)
    
        if @posts.size.positive?
          render json: @posts, status: :ok
        else
          render json: { message: 'No posts found' }, status: :not_found
        end
      end
    
    def show
      @post = Post.find(params[:id])

      render json: @post, status: :ok
    end
end

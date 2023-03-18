class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
    def index
        @post = Post.find(params[:post_id])
        comments = @post.comments
    
        if comments.size.positive?
          render json: comments, status: :ok
        else
          render json: { message: 'No comments found' }, status: :not_found
        end
      end
    
      def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(text: params[:text], author: current_user, post: @post)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: { message: 'Comment not created', erors: @comment.errors.messages },
                 status: :unprocessable_entity
        end
      end
end

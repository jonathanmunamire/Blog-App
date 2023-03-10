class UsersController < ApplicationController
  layout 'standard'
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end

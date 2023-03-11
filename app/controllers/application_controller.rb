class ApplicationController < ActionController::Base
  layout 'standard'

  def current_user
    User.first
  end
end

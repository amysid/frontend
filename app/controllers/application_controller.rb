class ApplicationController < ActionController::Base
  helper ApplicationHelper
    def current_user
    @current_user = User.find_by(id: session[:user_id])
    end

  def logged_in?
    redirect_to new_session_path unless current_user.present?
  end 
end

class ApplicationController < ActionController::Base
  before_action :ensure_user_authorized!
  include Rails.application.routes.url_helpers
  
  helper ApplicationHelper
    def current_user
    @current_user = User.find_by(id: session[:user_id])
    end

  def logged_in?
    redirect_to new_session_path unless current_user.present?
  end

  def ensure_user_authorized!
    return true if current_user.blank?
    return true if current_user.role == "Admin"
    action = "#{params[:controller]}-#{params[:action]}"
    return true if params[:controller] == "sessions"
    return true if current_user.accessible_features.include?(action)
    
    message = "Action not found or user not authorized"
    return redirect_to homes_path, alert: message
  end 
end

class ApplicationController < ActionController::Base
  before_action :ensure_user_authorized!
  before_action :set_locale

  protect_from_forgery with: :null_session

  include Rails.application.routes.url_helpers
  include HTTParty

  def fetch_categories
    url = "#{ENV["API_BASE_URL"]}/api/categories"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? && response_body.dig("categories").present? && response_body.dig("categories").dig("data").present?
      @categories =  response_body["categories"]["data"]
    end
    @category_options = @categories.to_a.map do |c|
      next if c["attributes"].blank?
      [c["attributes"]["name"], c["attributes"]["id"]]
    end.compact 
  end

  helper ApplicationHelper
  
  def current_user
    @current_user = session[:user] #User.find_by(id: session[:user_id])
  end

  def logged_in?
    redirect_to new_session_path unless current_user.present?
  end

  def set_locale
    I18n.locale = :en
    I18n.locale = params[:locale]
  end

  def ensure_user_authorized!
    return true if current_user.blank?
    return true if current_user["role"] == "Admin"
    action = "#{params[:controller]}-#{params[:action]}"
    return true if params[:controller] == "sessions"
    return true if accessible_features.include?(action)
    
    message = "Action not found or user not authorized"
    return redirect_to homes_path, alert: message
  end

  def accessible_features
    if current_user["role"] == "operator"
      feature = ["homes-index", "books-index", "books-show", "books-create","books-update",
                "books-setting", "books-edit", "books-destroy", "booths-index", "booths-create",
               "booths-show", "booths-edit", "booths-destroy", "booths-setting", "booths-update"]
      return feature
    elsif current_user["role"] == "Approver"
      return ["homes-index","books-index", "books-edit", "books-show", "books-update","books-setting", "books-change-status"]
    else
      return []
    end
  end

end

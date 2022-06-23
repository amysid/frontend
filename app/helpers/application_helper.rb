module ApplicationHelper

	def logged_in?
		!!session[:user]
  end

  def current_user
     @current_user ||= session[:user] #User.find_by_id(session[:user_id]) if !!session[:user_id]
  end

  def accessible?(action)
    return true if current_user["role"] == "Admin"
    return true if accessible_features.include?(action)
    return false
   end

end

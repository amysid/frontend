module ApplicationHelper

	def logged_in?
		!!session[:user]
  end

  def current_user
     @current_user ||= session[:user] #User.find_by_id(session[:user_id]) if !!session[:user_id]
  end

  def accessible?(action)
    return true if current_user["role"] == "Admin"
    return true if accessible_features.to_a.include?(action)
    return false
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

class SessionsController < ApplicationController
	before_action :logged_in?, only: [:destroy]
  def new
  	@user = User.new
  end

  def create
      @user = User.find_by(email: params[:email])
      if !!@user && @user.authenticate(params[:password])
      	  session[:user_id] = @user.id
          redirect_to homes_path
      else

      	massage = "Something went wrong"
      	redirect_to root_path, notice: massage
      end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
	session[:user_id] = nil
	flash[:success] = t('logout_successfull')
    redirect_to root_path
  end

end

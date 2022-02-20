class UsersController < ApplicationController
  before_action :logged_in?, except: [:create]
  def index
    @users = User.all
  end

  def create
  end
end

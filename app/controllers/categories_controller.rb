class CategoriesController < ApplicationController
  before_action :logged_in?
  def index
    @categories = Category.all
  end
end

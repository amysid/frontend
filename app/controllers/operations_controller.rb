class OperationsController < ApplicationController
  before_action :logged_in?
  
  def index
    per_page = params[:per_page] || 10
    @operations = Operation.all.includes(:book, :booth).order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end
end

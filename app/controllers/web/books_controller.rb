class Web::BooksController < ApplicationController
  before_action :set_booth
  before_action :fetch_categories
  
  def index
    byebug if params[:book].present? && params[:book][:name].present?
    @books = Book.where(category_id: @categories.pluck(:id))
  end

  def show
    @book = Book.where(id: params[:id]).first
  end

  private

  def set_booth
    @booth = Booth.find_by(number: params[:booth_id])
    redirect_to web_booth_path(id: @booth.number), notice: "Invali Booth" if @booth.blank?
  end

  def fetch_categories
    @categories = @booth.categories
  end
end

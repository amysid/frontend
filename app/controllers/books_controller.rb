class BooksController < ApplicationController
  before_action :logged_in?
  before_action :set_book, except: [:new, :create, :index]
  before_action :ensure_book_present?, except: [:new, :create, :index]
  before_action :fetch_categories, only: [:index, :edit]

  def index
    @book = Book.new
    @book.book_files.build
    url = "#{ENV["API_BASE_URL"]}/api/books"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @books =  response_body["books"]["data"]
    end
  end
  
  def create
    url = "#{ENV["API_BASE_URL"]}/api/books"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      redirect_to books_path
    end
  end

  def update 
    url = "#{ENV["API_BASE_URL"]}/api/books/#{params[:id]}"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.put(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      redirect_to books_path
    end
  end

  def show
  end

  def edit
  end

  def setting
  end

  def change_status
    status = @book.status == "Published" ? "UnPublished" : "Published"
    @book.update(status: status)
    redirect_to books_path, notice: t("book_updated_successfully")
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: t("book_deleted_successfully")
  end

  private

  def book_params
    params.require(:book).permit(:title, :language, :arabic_author_name, :arabic_title, :arabic_body, :author_name, :book_duration, :body,
      :user_id, :audio_type, book_files_attributes: [:id, :book_cover_file, :audio, :short_audio_file, :_destroy]
    )
  end

  def set_book
    url = "#{ENV["API_BASE_URL"]}/api/books/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      @book = response_body["book"]["data"]["attributes"]
    end
  end

  def ensure_book_present?
    if @book.blank?
      redirect_to books_path, alert: t("booth_not_found")
    end
  end

  def ensure_category_present?
    @categories = Category.where(id: params[:book][:category_ids])
    if @categories.blank?
      redirect_to books_path, alert: t('category_not_valid')
    end
  end

  def update_category_record
    existing_category_id = @book.category_ids
    category_ids_for_remove = existing_category_id - @categories.pluck(:id)
    @book.category_ids -= category_ids_for_remove
    @new_categories = @categories.where.not(id: existing_category_id)
  end
end

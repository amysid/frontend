class BooksController < ApplicationController
  before_action :logged_in?
  before_action :set_book, except: [:new, :create, :index]
  before_action :ensure_book_present?, except: [:new, :create, :index]
  before_action :fetch_categories, only: [:index, :edit]
  before_action :validate_files, only: [:create, :update]
  include Rails.application.routes.url_helpers

  def index
    url = "#{ENV["API_BASE_URL"]}/api/books"
    headers = {"Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, body: params.as_json, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @books =  response_body["books"]["data"]
      @pagination_data =  response_body["books"]["meta"]
    end
  end
  
  def create
    @store = Store.new({
      model_type: "Book",
      name: params[:book][:title],
      book_cover_file: params[:book][:book_cover_file],
      audio: params[:book][:audio],
      short_audio_file: params[:book][:short_audio_file]
      })
      @store.save 
    url = "#{ENV["API_BASE_URL"]}/api/books"
    if params["book"].present?
      data = {}
      data["book"] = {}
      data["book"] = book_params
      data["book"]["category_ids"] = params["book"]["category_ids"]
      data["book"]["cover"] =  rails_blob_path(@store.book_cover_file, only_path: true) if params["book"]["book_cover_file"].present?
      data["book"]["long"] =  rails_blob_path(@store.audio, only_path: true) if params["book"]["audio"].present?
      data["book"]["short"] =  rails_blob_path(@store.short_audio_file, only_path: true) if params["book"]["short_audio_file"].present?
      # data["book"]["book_cover_file"] =  File.open(params["book"]["book_cover_file"].tempfile.path) if params["book"]["book_cover_file"].present?
      # data["book"]["audio"] =  File.open(params["book"]["audio"].tempfile.path) if params["book"]["audio"].present?
      # data["book"]["short_audio_file"] =  File.open(params["book"]["short_audio_file"].tempfile.path) if params["book"]["short_audio_file"].present?
    end
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: data}
    response = HTTParty.post(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      @store.update(ref_id: response_body["book"]["data"]["id"].to_i)
      redirect_to books_path
    end
  end

  def update
    @store = Store.find_by(model_type: "Book", ref_id: params["id"].to_i)
    @store = @store.update({
      name: params[:book][:title],
      book_cover_file: params[:book][:book_cover_file],
      audio: params[:book][:audio],
      short_audio_file: params[:book][:short_audio_file]
      })
    @store = Store.find_by(model_type: "Book", ref_id: params["id"].to_i)
    url = "#{ENV["API_BASE_URL"]}/api/books/#{params[:id]}"
    if params["book"].present?
      data = {}
      data["book"] = {}
      data["book"] = book_params
      data["book"]["category_ids"] = params["book"]["category_ids"]
      data["book"]["cover"] =  rails_blob_path(@store.book_cover_file, only_path: true) if params["book"]["book_cover_file"].present?
      data["book"]["long"] =  rails_blob_path(@store.audio, only_path: true) if params["book"]["audio"].present?
      data["book"]["short"] =  rails_blob_path(@store.short_audio_file, only_path: true) if params["book"]["short_audio_file"].present?
      # data["book"]["book_cover_file"] =  File.open(params["book"]["book_cover_file"].tempfile.path) if params["book"]["book_cover_file"].present?
      # data["book"]["audio"] =  File.open(params["book"]["audio"].tempfile.path) if params["book"]["audio"].present?
      # data["book"]["short_audio_file"] =  File.open(params["book"]["short_audio_file"].tempfile.path) if params["book"]["short_audio_file"].present?
    end
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: data}
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
    url = "#{ENV["API_BASE_URL"]}/api/books/#{params[:id]}/change_status"
    headers = {headers: {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"},multipart: true, body: params.as_json}
    response = HTTParty.get(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      redirect_to books_path
    end
  end
#working
  def destroy
    url = "#{ENV["API_BASE_URL"]}/api/books/#{params[:id]}"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.delete(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body["status_code"] == 200
      message = t("book_deleted_successfully")
      redirect_to books_path, notice: message
    else
      redirect_to books_path, notice: t("something_went_wrong")
    end
  end

  private

  def book_params
     params.require(:book).permit(:title, :language, :arabic_author_name, :arabic_title, :arabic_body, :author_name, :book_duration, :body,
      :user_id, :audio_type
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

  def validate_files
    status = true
    if params["book"]["book_cover_file"].present?
      book_cover_extention = params["book"]["book_cover_file"].original_filename.split(".").last
      status = status && ['gif','png','jpg','jpeg'].include?(book_cover_extention)
    end
    if params["book"]["audio"].present?
      audio_extention = params["book"]["audio"].original_filename.split(".").last
      status = status && ["mp3"].include?(audio_extention)
    end
    if params["book"]["short_audio_file"].present?
      audio_extention = params["book"]["short_audio_file"].original_filename.split(".").last
      status = status && ["mp3"].include?(audio_extention)
    end
    return true if status
    redirect_to books_path, notice: t("File are not valid!")
  end
end

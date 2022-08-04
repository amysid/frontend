class Web::BooksController < Web::WebApplicationController
  before_action :set_booth , except: [:all_books, :play_book_for_blind]
  before_action :fetch_categories, only: :index
  before_action :set_category, only: :category_search

  def index
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").present? && response_body.dig("trending_books").present?
      @books = response_body["books"]["data"] rescue []
      @trending_books = response_body["trending_books"]["data"] rescue []
    end
  end

  def search
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/search"
    headers = {headers: {"Content-Type": "application/json"},multipart: true, body: params.as_json}
    response = HTTParty.get(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? && response_body.dig("books").present?
      @books = response_body["books"]["data"] rescue []
    end
  end

  def category_search
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/category_search"
    headers = {headers: {"Content-Type": "application/json"}, multipart: true, body: params.as_json}
    response = HTTParty.get(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? && response_body.dig("books").present?
      @books = response_body["books"]["data"] rescue []
      @total_books = response_body["total_books"]
      @total_time = response_body["total_time"]
      @total_author_count = response_body["total_author_count"]
    end
  end

  def show
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/#{params[:id]}"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").dig("data").present?
      @book = response_body["book"]["data"]["attributes"]
      @qr_png_url = response_body["qr_png_link"]
    end
  end

  def accessibility_mode
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/accessibility_mode"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @books = response_body["books"]["data"] rescue []
    end
  end

  def children_mode
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/children_mode"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @books = response_body["books"]["data"] rescue []
    end
  end

  def all_books
    url = "#{ENV["API_BASE_URL"]}/web_api/all_books"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("books").dig("data").present?
      @books = response_body["books"]["data"] rescue []
    end
  end

  def play_book_for_blind
    id = params[:id]
    url = "#{ENV["API_BASE_URL"]}/web_api/create_operation_for_blind"
    headers = {headers: {"Content-Type": "application/json"},multipart: true, body: params.as_json}
    response = HTTParty.get(url, headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present?
     operation_number = response_body["operation_number"]
    end
    redirect_to media_files_web_operation_path(id: operation_number)
  end

  def media_files
    @book = Book.where(id: params[:id]).includes(:book_files).first
    @book.update(last_listening_at: Time.now)
  end

  def update_listen_count
    render json: {message: "successfully save count"}
  end

  private

  def set_booth
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("booth").dig("data").present?
      @booth = response_body["booth"]["data"]["attributes"]
    end
  end

  def ensure_booth_present?
    if @booth.blank?
      redirect_to booths_path, alert: t("booth_not_found")
    end
  end

  def fetch_categories
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/categories"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("categories").present?
      @categories = response_body["categories"]["data"]
    end 
  end

  def set_category
    url = "#{ENV["API_BASE_URL"]}/web_api/booths/#{params[:booth_id]}/books/category_datail"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers, multipart: true, body: params.as_json)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("category").dig("data").present?
      @category = response_body["category"]["data"]["attributes"]
    end
  end

end
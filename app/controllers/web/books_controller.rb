class Web::BooksController < Web::WebApplicationController
  before_action :set_booth
  before_action :fetch_categories, only: :index

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
    if params[:book].present?
      book_ids = @booth.books.pluck(:book_id)
      @books = Book.includes(:book_files).where(id: book_ids, status: "Published").order('created_at desc')
      @books = @books.includes(:book_files).where("books.title ILIKE ? OR books.author_name ILIKE ?  OR books.body ILIKE ?", "%#{params[:book]}%", "%#{params[:book]}%", "%#{params[:book]}%" ).order('created_at desc')
    end
    if params[:type] == "all"
     @books = @books
    elsif params[:type] == "short"
      @books = @books.where(audio_type: "Short") if @books.present?
    elsif params[:type] == "long"
      @books = @books.where(audio_type: "Long") if @books.present?
    end
  end

  def category_search
    if params[:category_id].present?
      book_ids = @booth.books.pluck(:book_id)
      @books = Book.includes(:book_files).where(id: book_ids, status: "Published")
      book_ids = @categories.pluck(:book_id)
      @books = @books.where(id: book_ids)
      @total_books = @books.count || 0
      total_time = @books.pluck(:book_duration).sum
      @total_time = Time.at(total_time).utc.strftime("%Hh %M minute")
      @total_author_count = @books.pluck(:author_name).uniq.count || 0
      
      if params[:type] == "all"
        @books = @books
      elsif params[:type] == "short"
        @books = @books.where(audio_type: "Short")
      elsif params[:type] == "long"
        @books = @books.where(audio_type: "Long")
      end
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
    book_ids = @booth.books.pluck(:book_id)
    @books = Book.includes(:book_files).where(id: book_ids, status: "Published").order('created_at desc')
  end

  def children_mode
    @children_category = Category.where(name: "Children’s books").first
    cat_book_ids = @children_category.books.pluck(:id)
    book_ids = @booth.books.pluck(:book_id) & cat_book_ids
    
    @books = Book.includes(:book_files).where(id: book_ids, status: "Published").order('created_at desc')
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
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
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
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("categories").present?
      @categories = response_body["categories"]["data"]
    end 
  end

end
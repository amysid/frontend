class HomesController < ApplicationController
  before_action :logged_in?

  def index
    url = "#{ENV["API_BASE_URL"]}/api/homes"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer #{session[:token]}"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    return render_token_invalid_error if response_body.present? && response_body["status_code"] == 301

    if response_body.present? &&  response_body.dig("data").present?
      @data =  response_body["data"]
    end
  end

  # def index 
  #   @operations = Operation.includes(:book, booth: :categories).references(:book, booth: :categories)
  #   @operations_with_listening_status = @operations.where.not(listening_status: nil)
  #   @books = Book.all
  #   @booths = Booth.all
  #   @category_group = @operations_with_listening_status.group("categories.name").count
  #   @booth_details = @operations.group("booths.name").count
  #   @last_10_day_listing = @operations.where("operations.created_at > '#{(Time.now - 10.days)}'")
  #   @book_details = @operations.group("books.title").count
  #   @book_details =  Hash[@book_details.sort_by{|k, v| v}.reverse].first(5).to_h
  #   @rating_wise_group = @operations.group(:rating).count
  #   @book_language_detail = @operations.group(:language).count
  #   @book_listening_type  = @operations.group("books.audio_type").count.map { |k, v| [Book.audio_types.key(k), v] }.to_h
  # end
	
  # def index
  #   @operations = Operation.includes(:book, :booth).where.not(listening_status: nil)
  #   @books = Book.all.includes(:operations)
  #   @booths = Booth.all.includes(:operations)
  #   @categories = Category.all.includes(:books)
    
  #   @category_group  = @categories.map do |category|
  #     category_name = category.name
  #     book_ids = category.books.map(&:id)
  #     listen_by_category = @operations.where(book_id: book_ids).count
  #     [category_name, listen_by_category]
  #   end.to_h

  #   @booth_details = @booths.all.each_with_object({}) do |booth, hash|
  #     hash[booth.name] = booth.operations.count
  #   end
  #   @booth_details = @booth_details.sort_by { |acc, ct| ct }.reverse.first(5).to_h
    
  #   @last_10_day_listing = @operations.where("created_at > '#{(Time.now - 10.days)}'")
    
  #   @book_details = 
  #   @book_details = @books.all.each_with_object({}) do |book, hash|
  #     hash[book.title] = book.operations.count
  #   end
  #   @book_details = @book_details.sort_by { |acc, ct| ct }.reverse.first(5).to_h
    
  #   @rating_wise_group = @operations.group(:rating).count


  #   # .includes(:book).references(:book).group("books.title").count
  # end
end

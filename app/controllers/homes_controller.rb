class HomesController < ApplicationController
  before_action :logged_in?
	
  def index
    @operations = Operation.where.not(listening_status: nil)
    @books = Book.all.includes(:operations)
    @booths = Booth.all.includes(:operations)
    @categories = Category.all.includes(:books)
    @category_group  = @categories.map do |category|
      category_name = category.name
      book_ids = category.books.map(&:id)
      listen_by_category = @operations.where(book_id: book_ids).count
      [category_name, listen_by_category]
    end.to_h
    @booth_details = @booths.all.each_with_object({}) do |booth, hash|
      hash[booth.name] = booth.operations.count
    end
    @booth_details = @booth_details.sort_by { |acc, ct| ct }.reverse.first(5).to_h
    @last_10_day_listing = @operations.where("created_at > '#{(Time.now - 10.days)}'")
    @book_details = @books.all.each_with_object({}) do |book, hash|
      hash[book.title] = book.operations.count
    end
    @book_details = @book_details.sort_by { |acc, ct| ct }.reverse.first(5).to_h
  end
end

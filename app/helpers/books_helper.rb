module BooksHelper
  def total_time_in_minute(book)
    total = book.operations.sum(:listening_status)
    return Time.at(total).utc.strftime("%H:%M:%S")
  end
end

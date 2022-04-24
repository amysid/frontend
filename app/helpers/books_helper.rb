module BooksHelper
  def total_time_in_minute(book)
    sum = book.operations.sum(:listening_status)
    sum_array = sum.divmod 1
    min_in_second = sum_array.first * 60
    second = sum_array.last
    total = min_in_second + second
    return Time.at(total).utc.strftime("%H:%M:%S")
  end
end

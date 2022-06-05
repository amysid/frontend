module BoothsHelper
  def listening_count_for(booth)
    return booth.operations.select{|x| x.listening_status != nil}.count
  end

  def book_detail_for(booth)
    books = booth.books
    h = {}
    book_count_language_wise = books.group(:language).count
    h.merge!(book_count_language_wise)
    book_count_type_wise = books.group("books.audio_type").count
    h.merge!(book_count_type_wise)
    return h
  end

  def day_wise_info_for(booth, operations) 
    booth_ops = operations.where(booth_id: booth.id)
    return booth_ops.group_by_day_of_week(:created_at, format: "%a").count
  end
end

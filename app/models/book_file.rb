class BookFile < ApplicationRecord
  belongs_to :book
  has_one_attached :book_cover_file
  has_one_attached :audio
  has_one_attached :short_audio

end

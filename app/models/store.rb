class Store < ActiveRecord::Base
  has_one_attached :icon, dependent: :destroy
  has_one_attached :white_icon, dependent: :destroy
  has_one_attached :book_cover_file, dependent: :destroy
  has_one_attached :audio, dependent: :destroy
  has_one_attached :short_audio_file, dependent: :destroy
end

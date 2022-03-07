class Book < ApplicationRecord
  has_many :book_files,dependent: :destroy
  # has_and_belongs_to_many :categories
  belongs_to :category
  belongs_to :user, optional: true
  
  def book_files_attributes=(book_files_attributes)
    book_files_attributes.each do |i, book_file_attribute|
      self.book_files.build(book_file_attribute)
    end
  end
 
end

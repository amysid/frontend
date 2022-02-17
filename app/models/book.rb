class Book < ApplicationRecord
  belongs_to :user
  has_many :book_files,dependent: :destroy
  has_and_belongs_to_many :categories
  belongs_to :user
  
  
 
end

class Book < ApplicationRecord
  has_many :book_files,dependent: :destroy
  # has_and_belongs_to_many :categories
  accepts_nested_attributes_for :book_files 
  belongs_to :category
  belongs_to :user, optional: true
  enum status: ["UnPublished", "Published"]
  
end

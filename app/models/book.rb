class Book < ApplicationRecord
  has_many :book_files,dependent: :destroy
  has_many :operations, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  accepts_nested_attributes_for :book_files 
  belongs_to :category
  enum status: ["UnPublished", "Published"]
  
end

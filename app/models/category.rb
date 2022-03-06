class Category < ApplicationRecord
  # has_and_belongs_to_many :books
  has_many :books, dependent: :destroy
  has_and_belongs_to_many :booths, dependent: :destroy
  
  enum status: ["Active","Inactive"]
end

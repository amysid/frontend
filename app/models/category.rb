class Category < ApplicationRecord
  # has_and_belongs_to_many :books
  has_many :books
  has_and_belongs_to_many :booths
  
  enum status: ["Active","Inactive"]
end

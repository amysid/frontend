class Booth < ApplicationRecord
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users
  
  enum status: ["Active","Inactive"]
end

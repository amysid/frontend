class Operation < ApplicationRecord
  has_secure_token :number
  
  belongs_to :booth, dependent: :destroy
  belongs_to :book, dependent: :destroy
end

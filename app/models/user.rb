class User < ApplicationRecord
  has_secure_password
  enum gender: ["Male","Female"]
  enum role: ["Admin","Author", "Evaluator", "Editor", "Publisher", "Support", "User"]
  enum status: ["Invited","Active","Blocked"]
  has_many :books,dependent: :destroy
  has_and_belongs_to_many :booths
  
end

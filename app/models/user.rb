class User < ApplicationRecord
  has_secure_password
  enum gender: ["Male","Female"]
  enum role: ["Admin","Author", "Evaluator", "Editor", "Publisher", "Support", "User"]
  enum status: ["Invited","Active","Blocked"]
  has_many :books,dependent: :destroy
  has_and_belongs_to_many :booths

  after_create :send_invitation
  private
  def send_invitation
    generate_verificatin_link
    UserMailer.send_invitation_link(self).deliver_now
  end

  def generate_verificatin_link
    self.reload
    token = SecureRandom.urlsafe_base64(64).gsub(/[\-_]/, "")
    self.update(verificatin_link: token)
  end
  
end

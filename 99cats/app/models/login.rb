class Login < ActiveRecord::Base
  after_initialize :set_session_token!
  validates :user_id, :auth_token, :user_agent, :remote_address, presence: true
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
    )


  def reset_session_token!
    self.auth_token = SecureRandom::urlsafe_base64(16)
    self.save!
  end  
  
  def set_session_token!
    self.auth_token ||= SecureRandom::urlsafe_base64(16)
  end
  
end
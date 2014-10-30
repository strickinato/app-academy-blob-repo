class User < ActiveRecord::Base
  
  after_initialize :set_session_token!
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true  
  
  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :logins,
    class_name: "Login",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
    )
  
  def self.find_by_credentials(user_name, password)
    return nil if password.empty?
    return nil unless User.find_by_username(user_name)
    user = self.find_by_username(user_name)
    user.is_password?(password) ? user : nil
  end
  
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
  end
  
  def set_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
 
 
end
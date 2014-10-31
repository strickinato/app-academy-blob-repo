class User < ActiveRecord::Base
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { 
    minimum: 6, 
  }
  
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end

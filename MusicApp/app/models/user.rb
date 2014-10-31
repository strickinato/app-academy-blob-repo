class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates(
    :password,
    length: { minimum: 6, allow_nil: true }
  )

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end


  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end

#
# class User < ActiveRecord::Base
#   attr_reader :password
#
#   has_many :cats
#
#   after_initialize :ensure_session_token
#
#   validates :password_digest, presence: true
#   # If a password was set, we validate it meets the requirements.
#   # Note the `allow_nil`.
#   validates(
#     :password,
#     length: { minimum: 6, allow_nil: true }
#   )
#   validates :session_token, presence: true, uniqueness: true
#   validates :username, presence: true, uniqueness: true
#
#   def self.find_by_credentials(username, password)
#     user = User.find_by(username: username)
#
#     return nil if user.nil?
#     user.is_password?(password) ? user : nil
#   end
#
#   def is_password?(password)
#     BCrypt::Password.new(self.password_digest).is_password?(password)
#   end
#
#   def owns_cat?(cat)
#     cat.user_id == self.id
#   end
#
#   def password=(password)
#     # BCrypt will happily encrypt an empty string, thus falsely
#     # setting the password_digest. Ugh.
#     return unless password.present?
#
#     @password = password
#     self.password_digest = BCrypt::Password.create(password)
#   end
#
#   def reset_session_token!
#     self.session_token = SecureRandom.urlsafe_base64(16)
#     self.save!
#     self.session_token
#   end
#
#   private
#
#   def ensure_session_token
#     self.session_token ||= SecureRandom.urlsafe_base64(16)
#   end
# end

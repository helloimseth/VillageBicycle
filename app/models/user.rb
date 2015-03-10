class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token,
            :fname, :lname, presence: true

  validates :email, uniqueness: true;
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token, :default_activated_to_false

  belongs_to :neighborhood, inverse_of: :users
  has_one :size, as: :sizables

  def self.find_by_credentials(email, password)
    user = User.find_by email: email

    return user if user && user.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token

    self.save!

    self.session_token
  end

  private

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end

    def default_activated_to_false
      self.activated = false
    end

    def set_activation_token

    end

end

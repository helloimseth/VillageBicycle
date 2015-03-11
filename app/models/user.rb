class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token,
            :fname, :lname, presence: true

  validates :email, uniqueness: true;
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password, confirmation: true

  has_attached_file :picture, styles: { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  attr_reader :password

  after_initialize :ensure_session_token, :default_activated_to_false,
                   :set_activation_token

  belongs_to :neighborhood, inverse_of: :users
  belongs_to :size, inverse_of: :users

  has_many :bikes,
    class_name: "Bike",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :owner

  def self.find_by_credentials(email, password)
    user = User.find_by email: email

    return user if user && user.is_password?(password)
  end

  def self.generate_token
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
    self.session_token = User.generate_token

    self.save!

    self.session_token
  end

  private

    def ensure_session_token
      self.session_token ||= User.generate_token
    end

    def default_activated_to_false
      self.activated ||= false
    end

    def set_activation_token
      self.activation_token = User.generate_token
    end

end

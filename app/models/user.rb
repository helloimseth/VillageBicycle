class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token,
            :fname, :lname, presence: true

  validates :email, uniqueness: true;
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

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

end

# create_table "users", force: :cascade do |t|
#   t.string   "email",           null: false
#   t.string   "password_digest", null: false
#   t.string   "session_token",   null: false
#   t.string   "fname",           null: false
#   t.string   "lname",           null: false
#   t.text     "bio"
#   t.integer  "street_number"
#   t.string   "street"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
# end

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token,
            :fname, :lname, presence: true

  validates :email, uniqueness: true;
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password, confirmation: true

  has_attached_file :picture, styles: { :medium => "150x150>", :thumb => "100x100>" }, default_url: ":style/blank_user.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  attr_reader :password

  after_initialize :ensure_session_token, :default_activated_to_false,
                   :set_activation_token

  geocoded_by :address_for_geocoding
  after_validation :geocode

  include PgSearch
  multisearchable :against => [:fname]

  belongs_to :neighborhood, inverse_of: :users
  belongs_to :size, inverse_of: :users

  has_many :bikes,
    class_name: "Bike",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :owner,
    dependent: :destroy
  has_many :requests_for, through: :bikes, source: :requests

  has_many :requests_made,
    class_name: "Request",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :requestor,
    dependent: :destroy
  has_many :requested_bikes, through: :requests_made, source: :bike

  def self.find_by_credentials(email, password)
    user = User.find_by email: email

    return user if user && user.is_password?(password)
  end

  def self.find_by_auth_hash(hash)
    User.find_by(provider: hash[:provider],
                 uid: hash[:uid])
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

  def name
    "#{self.fname} #{self.lname[0]}"
  end

  def pending_requests_for
    self.requests_for.select{ |req| req.approved.nil? }
  end

  def approved_requests
    self.requests_for.select{|req| req.approved == true }
  end

  def pending_requests_made
    self.requests_made.select{ |req| req.approved.nil? }
  end

  def reservations
    self.requests_made.select{|req| req.approved == true }
  end

  def self.new_demo_user
    user = User.find_by(email: 'user@example.com')
    user.destroy if user

    user = User.create!(email: 'user@example.com',
                        password: 'password',
                        fname: 'Seth',
                        lname: 'Hamlin',
                        address: '598 Broadway, New York',
                        neighborhood: Neighborhood.find_by(name: 'SoHo'),
                        size: Size.find_by(size: 'M'),
                        activated: true)

    user.add_requests_made_seeds
    user.add_bike_seeds
    user.add_requests_for_seeds
    user
  end

  def add_requests_made_seeds
    6.times do
      Request.new_request_seed(self, Bike.all.sample)
    end
  end

  def add_requests_for_seeds
    6.times do
      user = User.all.sample

      while user == self
        user = User.all.sample
      end

      Request.new_request_seed(user, self.bikes.sample)
    end
  end

  def add_bike_seeds
    3.times do
      Bike.create_bike_owned_by(self)
    end
  end
  private



    def address_for_geocoding
      "#{self.address} New York City"
    end

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

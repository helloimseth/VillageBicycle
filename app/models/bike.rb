class Bike < ActiveRecord::Base
  validates :name, :gender, :size, :num_gears,
            :hourly_price, :category, presence: true
  validates :gender, inclusion: { in: %w( Men's Women's ) }

  has_attached_file :picture, styles: { :medium => "150x150>", :thumb => "100x100>" }, default_url: ":style/blank_bicycle.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  include PgSearch
  multisearchable :against => :name

  belongs_to :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :bikes

  belongs_to :size, inverse_of: :bikes
  belongs_to :category, inverse_of: :bikes

  has_many :add_ons,
  dependent: :destroy

  has_many :extras, through: :add_ons, source: :extra

  has_many :requests,
    dependent: :destroy

  has_many :requestors, through: :requests, source: :requestor

  def self.search(query)
    query_string = ""
    query_params = []

    query[:bike].each do |category, param|
      unless param.blank?
        query_string << "bikes.#{category} = ? AND "
        query_params << param
      end
    end

    unless query[:owner][:neighborhood_id].blank?
      query_string << "users.neighborhood_id = ?"
      query_params << query[:owner][:neighborhood_id]
    end

    query_params.unshift(query_string)

    if query[:request][:start].blank? || query[:request][:end].blank?
      query_params[0].sub!(/\sAND\s$/, "")

      Bike.joins(:owner)
          .where(query_params)
    else
      query_params[0] << " AND " unless query[:owner][:neighborhood_id].blank?
      query_params[0] << "(? > CAST(requests.end AS DATE) OR CAST(requests.start AS DATE) > ? OR requests.id IS NULL)"
      query_params.concat([query[:request][:start], query[:request][:end]])

      Bike.joins(:owner)
          .joins("LEFT JOIN requests ON requests.bike_id = bikes.id")
          .where(query_params)
    end
  end

  def self.maps_search_query(bikes)
    query_string = ""

    bikes.each do |bike|
      query_string += "markers=label:#{bike.owner.address},#{bike.neighborhood},New+York,NY&".gsub(" ","+")
    end

    query_string
  end

  def self.create_bike_owned_by(user)
    b = Bike.new(name: [Faker::Name.first_name, Faker::Team.creature, Faker::Hacker.noun].sample.capitalize,
                 gender: ["Men's", "Women's"].sample,
                 notes: Faker::Hacker.say_something_smart,
                 size: user.size,
                 num_gears: (1..25).to_a.sample,
                 hourly_price: (1..20).to_a.sample,
                 category: Category.all.sample,
                 owner: user)

    num_extras = [1,2,3,4,5].sample
    extras = []

    num_extras.times do
      extra = Extra.all.sample
      extras << extra unless extras.include?(extra)
    end

    b.extras = extras

    b.save!
  end

  def type
    self.category.name
  end

  def neighborhood
    self.owner.neighborhood.name
  end

  def owner_name
    "#{self.owner.fname} #{self.owner.lname[0]}"
  end

  def is_owned_by?(user)
    self.owner == user
  end

  private

    def only_search_by_bike_terms
      query[:owner][:neighborhood_id].blank? &&
      query[:dates][:start].blank? &&
      query[:dates][:end].blank?
    end
end


# SELECT
#   b.*
# FROM
#   bikes as b
# LEFT OUTER JOIN
#   requests as r ON r.bike_id = b.id
# WHERE
#   '2015-03-15' > CAST(r.end AS DATE) OR CAST(r.start AS DATE) > '2015-04-12' OR r.id IS NULL;

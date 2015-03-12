class Bike < ActiveRecord::Base
  validates :name, :gender, :size, :num_gears,
            :hourly_price, :category, presence: true
  validates :gender, inclusion: { in: %w( Men's Women's ) }

  has_attached_file :picture, styles: { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  belongs_to :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :bikes

  belongs_to :size, inverse_of: :bikes
  belongs_to :category, inverse_of: :bikes

  has_many :add_ons
  has_many :extras, through: :add_ons, source: :extra

  has_many :requests
  has_many :requestors, through: :requests, source: :requestor

  def self.search(query)
    query_string = ""
    query_params = []

    query[:bike].each do |category, param|
      unless param.blank? || category == :dates
        query_string << "bikes.#{category} = ? OR "
        query_params << param
      end
    end

    if query[:dates]
      query_string << "((bikes.start <= #{query[:dates][:start]} &&
                         bikes.end >= #{query[:dates][:start]}) ||
                         bike.start >=)"

    if
      query_params.unshift(query_string[0..-5])
      Bike.where(query_params)
    else
      query_string << "users.neighborhood_id = ?"
      query_params.unshift(query_string).push(query[:owner][:neighborhood_id])
      Bike.joins(:owner).where(query_params)
    end
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
      query[:dates][:start].blanky? &&
      query[:dates][:end].blanky?
    end
end

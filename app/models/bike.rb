class Bike < ActiveRecord::Base
  validates :name, :gender, :size, :num_gears,
            :hourly_price, :category, presence: true
  validates :gender, inclusion: { in: %w( Men's Women's )}

  belongs_to :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :bikes

  belongs_to :size, inverse_of: :bikes
  belongs_to :category, inverse_of: :bikes

  def type
    self.category.name
  end

  def neighborhood
    self.owner.neighborhood.name
  end

  def owner_name
    "#{self.owner.fname} #{self.owner.lname[0]}"
  end
end

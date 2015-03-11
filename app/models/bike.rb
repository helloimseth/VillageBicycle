class Bike < ActiveRecord::Base
  validates :name, :gender, :size, :num_gears,
            :hourly_price, :category, presence: true

  belongs_to :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :bikes

  belongs_to :size, inverse_of: :bikes
  belongs_to :category, inverse_of: :bikes
end

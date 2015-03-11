class AddOn < ActiveRecord::Base
  validates :bike, :extra, presence: true

  belongs_to :bike
  belongs_to :extra
end

class AddOn < ActiveRecord::Base
  validates :bike, :extra, presence: true

  belongs_to :bike, inverse_of: :add_ons
  belongs_to :extra, inverse_of: :addings
end

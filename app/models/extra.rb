class Extra < ActiveRecord::Base
  validates :name, presence: true

  has_many :addings,
    class_name: "AddOn",
    inverse_of: :extra

  has_many :bikes, through: :addings, source: :bike
end

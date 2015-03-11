class Extra < ActiveRecord::Base
  validates :name, presence: true

  has_many :addings,
    class_name: "AddOn",
    foreign_key: :extra_id,
    primary_key: :id,
    inverse_of: :extras

end

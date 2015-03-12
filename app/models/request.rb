class Request < ActiveRecord::Base
  validates :requestor, :bike, :start, :end, presence: true

  belongs_to :bike
  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id
end

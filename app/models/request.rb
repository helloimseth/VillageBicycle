class Request < ActiveRecord::Base
  validates :requestor, :bike, :start, :end, presence: true
  validate :start_must_be_before_end
  validate :cannot_request_own_bike

  belongs_to :bike
  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :requests_made

  def approve
    self.approved = true
  end

  def reject
    self.approved = false
  end

  private

    def start_must_be_before_end
      if self.end && self.start && self.end < self.start
        errors[:base] << "Start date must be before end date"
      end
    end

    def cannot_request_own_bike
      if self.requestor == self.bike.owner
        errors[:base] << "Can't rent your own bike!"
      end
    end

end

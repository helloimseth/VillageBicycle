class Request < ActiveRecord::Base
  validates :requestor, :bike, :start, :end, presence: true
  validate :start_must_be_before_end
  validate :cannot_request_own_bike
  validate :cannot_request_unavailable_bikes

  belongs_to :bike
  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :requests_made

  def approve!
    self.approved = true
    self.save!
  end

  def reject!
    self.approved = false
    self.save!
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

    def cannot_request_unavailable_bikes
      query = ["? > requests.end OR requests.start > ?", self.start, self.end]
      overlaps = Request.where(bike_id: self.bike_id)
                        .where(approved: true)
                        .where.not(query)
      if overlaps.any?
        errors[:base] << 'We sorry, that bike has already been
                          reserved during the requested time'
      end
    end

end

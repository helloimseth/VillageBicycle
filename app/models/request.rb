class Request < ActiveRecord::Base
  validates :requestor, :bike, :start, :end, presence: true
  validate :start_must_be_before_end
  validate :cannot_request_own_bike
  validate :cannot_request_unavailable_bikes

  attr_accessor :end_ampm, :end_hour, :end_min,
                :start_ampm, :start_hour, :start_min

  belongs_to :bike

  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id,
    inverse_of: :requests_made

  def self.new_request_seed(requestor, bike)
    start_date = (1..500).to_a.sample.days.from_now
    end_date = start_date + (1..10).to_a.sample.days

    r = requestor.requests_made.new(bike: bike,
                                    start: start_date,
                                    end: end_date,
                                    approved: [nil, true].sample)
    Request.new_request_seed(requestor, bike) unless r.save
  end

  def approve!
    self.approved = true
    self.save!
  end

  def reject!
    self.approved = false
    self.save!
  end

  def start_date=(date_string)
    date_parts = date_string.split('-').map(&:to_i)
    hour = self.start_ampm == 'AM' ? self.start_hour.to_i : self.start_hour.to_i + 12

    self.start = DateTime.new(date_parts[0], date_parts[1], date_parts[2],
                          hour.to_i, self.start_min.to_i)
  end

  def end_date=(date_string)
    date_parts = date_string.split('-').map(&:to_i)
    hour = self.end_ampm == 'AM' ? self.end_hour.to_i : self.end_hour.to_i + 12

    self.end = DateTime.new(date_parts[0], date_parts[1], date_parts[2],
                          hour.to_i, self.end_min.to_i)

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
      if overlaps.any? && self.approved != false
        errors[:base] << 'We sorry, that bike has already been
                          reserved during the requested time'
      end
    end

end

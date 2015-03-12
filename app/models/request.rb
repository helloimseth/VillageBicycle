class Request < ActiveRecord::Base
  validates :requestor, :bike, :start, :end, presence: true

  belongs_to :bike
  belongs_to :requestor,
    class_name: "User",
    foreign_key: :requestor_id,
    primary_key: :id

  attr_accessor :start_date, :start_time, :end_date, :end_time

  after_initialize :set_start_and_end_times

  def set_start_and_end_times
    self.set_time :start, @start_date, @start_time
    self.set_time :end, @end_date, @end_time
  end

  def set_time(time_attr, date, time)
    parsed_date = date.split("-")
    time = Time.new(parsed_date[0], parsed_date[1], parsed_date[2],
                    time.to_i/100, time.to_i % 100)
    self.send("#{time_attr}=", time)
  end
end

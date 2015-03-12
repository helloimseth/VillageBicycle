require 'rails_helper'
require 'rspec/rails'
require 'shoulda/matchers'

RSpec.describe Request, type: :model do
  subject do
    Request.new(requestor_id: 1, bike_id: 1,
                start: (Time.new + 100), end: Time.new)
  end
  context "validation" do
    it { should validate_presence_of(:requestor) }
    it { should validate_presence_of(:bike) }
    
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }

    it "won't save a request with a start date after end date" do
      expect(subject).not_to be_valid
    end
  end

  context "association" do
    it { should belong_to(:bike) }
    it { should belong_to(:requestor) }
  end

end

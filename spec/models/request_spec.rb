require 'rails_helper'

RSpec.describe Request, type: :model do
  context "validation" do
    it { should validate_presence_of(:requestor) }
    it { should validate_presence_of(:bike) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }
  end

  context "association" do
    it { should belong_to(:bike) }
    it { should belong_to(:requestor) }
  end

end

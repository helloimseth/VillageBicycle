require 'rails_helper'

RSpec.describe AddOn, type: :model do
  context "association" do
    it { should belong_to(:bike) }
    it { should belong_to(:extra) }
  end
end

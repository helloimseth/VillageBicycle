require 'rails_helper'
require 'test_helper'
require 'spec_helper'

RSpec.describe Bike, type: :model do

  context "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:gender) }
    it { should validate_inclusion_of(:gender).in_array(%w(Men's Women's)) }
    it { should validate_presence_of(:size) }
    it { should validate_presence_of(:num_gears) }
    it { should validate_presence_of(:hourly_price) }
    it { should validate_presence_of(:category) }
  end

  context "association" do
    it { should belong_to(:size) }
    it { should belong_to(:category) }
    it { should belong_to(:owner) }
  end
end

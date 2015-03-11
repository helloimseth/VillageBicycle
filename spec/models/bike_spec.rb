require 'rails_helper'
require 'test_helper'
require 'spec_helper'

RSpec.describe Bike, type: :model do
  let(:test_user) { double User, id: 1 }
  let(:test_size) { double Size, id: 1 }
  subject(:spec_bike) { Bike.new({
    owner_id: 1,
    name: "Lucy",
    type: "Road Bike",
    notes: "A very nice and speedy bike.",
    gender: "Men's",
    size_id: 1,
    num_gears: 6,
    hourly_price: 25
    })
  }

  context "validation" do
    it "requires a name" do
      :spec_bike.name = ""

      expect(:spec_bike).not_to be_valid
    end

    it "requires a category"
    it "won't validate a category of unknown type"
    it "requires a gender"
    it "requires a size"
    it "needs to know the number of gears"
    it "requires an hourly rent price"
  end
end

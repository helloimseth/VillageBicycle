require 'rails_helper'

RSpec.describe Extra, type: :model do
  context "association" do
    it { should have_many(:addings) }
    it { should have_many(:bikes) }
  end
end

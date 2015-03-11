require 'test_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do

    subject(:test_user) do
      User.new(email: "test@example.com", password: "password",
               fname: "John", lname: "Doe", bio: "Football fan!",
               address: "123 Main St.")
    end

    context "authentication" do
      it { should validate_length_of(:password).is_at_least(6) }

      it "won't save password to database" do
        test_user.save
        user = User.find_by(email: "test@example.com")

        expect(user.password).to be(nil)
      end
    end

    context "validation" do
      it { should validate_presence_of(:fname) }
      it { should validate_presence_of(:lname) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    context "association" do
      it { should belong_to(:size) }

      it { should belong_to(:neighborhood) }

      it { should have_many(:bikes) }
    end
  end

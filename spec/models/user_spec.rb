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
      it "has a size" do
        size = Size.new( id: 1 )
        test_user.size_id = 1

        expect(test_user.size).to be_an_instance_of(Size)
      end

      it "has a neighborhood"
      it "can have a bike"
    end
  end

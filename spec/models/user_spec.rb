require 'test_helper'
require 'spec_helper'

class UserTest < ActiveSupport::TestCase

  describe User do

    subject(:test_user) { User.new(email: "test@example.com",
                                   password: "password",
                                   fname: "John",
                                   lname: "Doe",
                                   bio: "Football fan!",
                                   street_number: 123,
                                   street: "Main St.") }

    context "authentication" do
      it "requires a password to be at least 6 characters" do
        test_user.password = "fail"

        expect(test_user).not_to be_valid
      end

      it "won't save password to database" do
        test_user.save
        user = User.find_by(email: "test@example.com")

        expect(user.password).to be(nil)
      end
    end

    context "validation" do
      it "requires users have First and Last Names" do
        test_user.fname, test_user.lname = nil, nil

        expect(test_user).not_to be_valid
      end

      it "requires an email address to save a user" do
        test_user.email = nil;

        expect(test_user).not_to be_valid
      end

      it "won't save a new user with existing email address" do
        new_test_user = User.new(email: "test@example.com", password: "password",
                                 fname: "Jane", lname: "Deer")

        expect(new_test_user).not_to be_valid
      end
    end

  end

end

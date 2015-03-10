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
      it "requires an email address to save a user" do
        test_user.email = nil;

        expect(test_user).not_to be_valid
      end

      it "won't save a new user with existing email address" do
        new_test_user = User.new(email: "test@example.com",
                                 password: "password",
                                 fname: "Jane",
                                 lname: "Deer",
                                 bio: "Soccer fan!",
                                 street_number: 123,
                                 street: "Avenue St.")

        expect(new_test_user).not_to be_valid
      end

      it "won't save password to database" do
        test_user.save
        user = User.find_by(email: "test@example.com")

        expect(user.password).to be(nil)
      end
    end

  end

end

# column name     | data type | details
# ----------------|-----------|-----------------------
# id              | integer   | not null, primary key
# email           | string    | not null, unique
# password_digest | string    | not null
# session_token   | string    | not null, unique
# first_name		| string	| not null
# last_name		| string	| not null
# bio				| string	|
# neighborhood_id | integer	| not null, foreign key (references neighborhoods)
# street_num		| integer	| *model level validation based on if they own bicycles
# street_name		| string	| *model level validation based on if they own bicycles
# size_id 		| integer	| not null, foreign key (references sizes)

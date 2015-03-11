class Neighborhood < ActiveRecord::Base
  has_many :users, inverse_of: :size
end

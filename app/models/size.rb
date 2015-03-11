class Size < ActiveRecord::Base
  has_many :users, inverse_of: :size
  has_many :bikes, inverse_of: :size
end

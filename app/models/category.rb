class Category < ActiveRecord::Base
  has_many :bikes, inverse_of: :category
end

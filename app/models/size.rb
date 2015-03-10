class Size < ActiveRecord::Base
  belongs_to :sizables, polymorphic: true
end

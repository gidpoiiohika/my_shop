class Cart < ApplicationRecord
	has_many    :positions
  belongs_to  :user,optional: true
  has_many  :items, through: :positions
end

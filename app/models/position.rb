class Position < ApplicationRecord
	attr_accessible :item_id, :cart_id, :quantity

  belongs_to  :item,optional: true
  belongs_to  :cart,optional: true
end

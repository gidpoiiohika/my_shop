class Order < ApplicationRecord
	attr_accessible :user, :user_id
	belongs_to :user,optional: true
end

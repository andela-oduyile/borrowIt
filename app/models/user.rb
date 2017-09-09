class User < ApplicationRecord
    has_many :owned_items, :class_name => "Request", :foreign_key => "owned_by_id"
    has_many :borrowed_items, :class_name => "Request", :foreign_key => "requested_by_id"
end

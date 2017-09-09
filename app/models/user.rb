class User < ApplicationRecord
    has_many :created_request, :class_name => 'Request', :foreign_key => 'requested_by_id'
    has_many :accepted_request, :class_name => 'Request', :foreign_key => 'owned_by_id'
end

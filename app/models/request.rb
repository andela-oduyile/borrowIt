class Request < ApplicationRecord
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owned_by_id'
  belongs_to :borrower, :class_name => 'User', :foreign_key => 'requested_by_id'
end

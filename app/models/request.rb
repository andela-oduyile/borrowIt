class Request < ApplicationRecord
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owned_by_id', optional: true
  belongs_to :borrower, :class_name => 'User', :foreign_key => 'requested_by_id'

  scope :unaccepted, -> { where(owner: nil) }
  scope :not_returned, -> { where(returned_at: nil) }
end

class Request < ApplicationRecord
  belongs_to :requestedBy, :class_name => 'User'
  belongs_to :ownedBy, :class_name => 'User'
end

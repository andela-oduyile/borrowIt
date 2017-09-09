class User < ApplicationRecord
    has_many :owned_items, :class_name => "Request", :foreign_key => "owned_by_id"
    has_many :borrowed_items, :class_name => "Request", :foreign_key => "requested_by_id"
    has_many :requests, foreign_key: "requested_by_id"

    def self.from_slack(user_hash)
      find_or_initialize_by(provider_id: user_hash[:provider_id] ) do |user|
        user.name = user_hash[:name]
        user.email = user_hash[:email]

        user.save
      end
    end

    def api_key
      JWTService.generate_token_for(self)
    end
end

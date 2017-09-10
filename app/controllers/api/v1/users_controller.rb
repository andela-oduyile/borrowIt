module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.find(params[:id])
        render json: user_data(user)
      end

      def me
        render json: user_data(current_user)
      end

      private
        def user_data(user)
          {
            message: "Fetching user details",
            data: {
                    name: user.name,
                    email: user.email,
                    id: user.id,
                    profile_image: user.profile_image
                  }
          }

        end
    end
  end
end

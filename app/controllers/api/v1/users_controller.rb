module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.find(params[:id])
        render json: {
                      message: "Fetching user details",
                      data: {
                        name: user.name,
                        email: user.email,
                        id: user.id
                      }
                    }
      end
    end
  end
end

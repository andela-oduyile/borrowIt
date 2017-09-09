module Api
  module V1
    class RequestsController < ApplicationController

      def index
        requests = Request.unaccepted.order('created_at DESC')
        render json: { message: "Fetching all open requests", data: requests}
      end

      def show
        request = Request.find(params[:id])
        render json: { message: "Fetching the request", data: request}
      end

      def create
        request = request_scope.new(request_params)
        if request.save
          render json: { message: "Created the request", data: request}
        else
          render json: { message: "Oops! an error occured while trying to create the request", data: request }
        end
      end

      def update
        request = request_scope.find(params[:id])
        if request.update(request_params)
          render json: { message: "Updated the request", data: request }
        else
          render json: { message: "Oops! an error occured while trying to update the request", data: request }
        end
      end

      def destroy
        request = request_scope.find(params[:id])
        request.destroy
        render json: { message: "Deleted this request", data: request }
      end

      def accept
        request = Request.find(params[:id])
        request.update(owner: current_user)

        render json: { message: "Accepted the request", data: request }
      end

      def leased
        requests = current_user.owned_items

        render json: { message: "Fetching all items given out", data: requests }
      end


      private

        def request_scope
          current_user.requests
        end

        def request_params
          params.permit(:requested_by_id, :owned_by_id, :status, :item, :description, :return_state, :owner_comment)
        end
    end
  end
end

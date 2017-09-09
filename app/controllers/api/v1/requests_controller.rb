module Api
  module V1
    class RequestsController < ApplicationController

      def index
        requests = Request.order('created_at DESC')
        render json: { message: "Fetching all requests", data: requests}
      end

      def show
        request = Request.find(params[:id])
        render json: { message: "Fetching the request", data: request}
      end

      def create
        request = Request.new(request_params)
        if request.save
          render json: { message: "Created the request", data: request}
        else
          render json: { message: "Oops! an error occured while trying to create the request", data: request }
        end
      end

      def update
        request = Request.find(params[:id])
        if request.update(request_params)
          render json: { message: "Updated the request", data: request }
        else
          render json: { message: "Oops! an error occured while trying to update the request", data: request }
        end
      end

      def destroy
        request = Request.find(params[:id])
        request.destroy
        render json: { message: "Deleted this request", data: request }
      end


      private

        def request_params
          params.permit(:requestedBy_id, :ownedBy_id, :status, :item, :description, :return_state, :owner_comment)
        end
    end
  end
end

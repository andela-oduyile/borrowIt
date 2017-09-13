module Api
  module V1
    class RequestsController < ApplicationController

      def index
        requests = Request.unaccepted.includes(:borrower, :owner).order('created_at DESC')
        render json: { message: "Fetching all open requests", data: serialize_request(requests)}
      end

      def show
        request = Request.includes(:borrower, :owner).find(params[:id])
        render json: { message: "Fetching the request", data: serialize_request(request)}
      end

      def create
        request = request_scope.new(request_params)
        if request.save
          request_url = FRONTEND_CONFIG.url + "request/#{request.id}"
          slack_notifier.ping "*Borrow-It Notifications* \n *New Request*\n *Item*: #{request.item} \n *Comment*: #{request.description}\n *Requester*: <@#{current_user.provider_id}>  \n *Visit:* [#{request_url}](#{request_url})"

          render json: { message: "Created the request", data: serialize_request(request)}
        else
          render json: { message: "Oops! an error occured while trying to create the request", data: serialize_request(request) }
        end
      end

      def update
        request = request_scope.find(params[:id])
        if request.update(request_params)
          render json: { message: "Updated the request", data: request }
        else
          render json: { message: "Oops! an error occured while trying to update the request", data: serialize_request(request) }
        end
      end

      def destroy
        request = request_scope.find(params[:id])
        request.destroy
        render json: { message: "Deleted this request", data: serialize_request(request) }
      end

      def accept
        request = Request.includes(:borrower, :owner).find(params[:id])
        request.update(owner: current_user)
        slack_notifier_user(request.borrower.provider_id).ping "*Borrow-It Notifications* \n *Request Confirmation*: Your request for item #{request.item} has been accepted by <@#{@current_user.provider_id}> "

        render json: { message: "Accepted the request", data: serialize_request(request) }
      end

      def leased
        requests = current_user.owned_items.not_returned

        render json: { message: "Fetching all items given out", data: serialize_request(requests) }
      end

      def borrowed
        requests = current_user.borrowed_items.not_returned

        render json: { message: "Fetching all items borrowed", data: serialize_request(requests) }
      end


      private

        def request_scope
          current_user.requests.includes(:borrower, :owner)
        end

        def serialize_request(request)
          request.as_json(include: [:borrower, :owner])
        end

        def request_params
          params.permit(:requested_by_id, :owned_by_id, :status, :item, :description, :return_state, :owner_comment)
        end
    end
  end
end

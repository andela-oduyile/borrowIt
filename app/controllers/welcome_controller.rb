class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    render json: { message: "Welcome to borrow-it app." }
  end
end

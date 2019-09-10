class BoatsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    boat = Boat.new(boat_params)
    if boat.save
      render json: boat
    else
      render json: boat.errors.messages.to_json, status: 400
    end
  end

  def show
    render json: Boat.find(params[:id])
  rescue ActiveRecord::RecordNotFound, e
    render json: { error: e.message }, status: :not_found
  end

  private

  def boat_params
    params.permit(:model, :length, :latitude, :longitude)
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end

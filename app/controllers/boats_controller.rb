class BoatsController < ApplicationController
  def create
    boat = Boat.new(boat_params)
    if boat.save
      render json: boat
    else
      render json: boat.errors.messages.to_json, status: 400
    end
  end

  private

  def boat_params
    params.permit(:model, :length, :latitude, :longitude)
  end
end

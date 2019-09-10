class BoatsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    query = Boat.ransack(model_eq: params[:model], length_eq: params[:length],
                      within: [params[:latitude], params[:longitude], params[:radius]])
    render json: query.result(distinct: true)
  end

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
  end

  def destroy
    Boat.find(params[:id]).destroy
  end

  private

  def boat_params
    params.permit(:model, :length, :latitude, :longitude)
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end

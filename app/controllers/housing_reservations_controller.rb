class HousingReservationsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  before_action :find_housing_reservation, except: [:index, :create]

  # GET /user/{user_id}/housing_reservations
  def index
    @housing_reservations = find_user.housing_reservations.all
    render json: @housing_reservations, status: :ok
  end
  
  # GET /user/{user_id}/housing_reservations/{id}
  def show
    render json: @housing_reservation, status: :ok
  end

  # POST /user/{user_id}/housing_reservations
  def create
    @housing_reservation = find_user.housing_reservations.build(housing_reservation_params)
    if @housing_reservation.save
      render json: @housing_reservation, status: :created
    else
      render json: { errors: @housing_reservation.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /user/{user_id}/housing_reservations/{id}
  def update
    @housing_reservation.assign_attributes(housing_reservation_params)
    unless @housing_reservation.save
      render json: { errors: @housing_reservation.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /user/{user_id}/housing_reservations/{id}
  def destroy
    @housing_reservation.destroy
  end

  private
  
  def find_user
    User.find_by_id!(params[:user_id])
  end

  def find_housing_reservation
    @housing_reservation = find_user.housing_reservations.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Reservation not found' }, status: :not_found
  end

  def housing_reservation_params
    params.permit(
      :start_date, :end_date, :nb_persons, :status, :housing_advert_id, :user_id
    )
  end
end

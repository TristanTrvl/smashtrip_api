class HousingReservationsController < ApplicationController
  before_action :authorize_request, :except => [:index, :show]

  # GET /user/{user_id}/housing_reservations
  def index
    if params[:user_id]
      @housing_reservations = find_user_housing_reservations.all
    elsif params[:housing_advert_id]
      @housing_reservations = find_advert_housing_reservations.all
    else
      @housing_reservations = HousingReservation.all
    end
    render json: @housing_reservations, :status => :ok
  end
  
  # GET /user/{user_id}/housing_reservations/{id}
  def show
    if params[:user_id]
      @housing_reservation = find_user_housing_reservations.find_by_id!(params[:id])
    elsif params[:housing_advert_id]
      @housing_reservation = find_advert_housing_reservations.find_by_id!(params[:id])
    else
      @housing_reservation = find_housing_reservation
    end
    render json: @housing_reservation, :status => :ok
  end

  # POST /housing_reservations
  def create
    @housing_reservation = HousingReservation.new(housing_reservation_params)
    if @housing_reservation.save
      render json: @housing_reservation, :status => :created
    else
      render json: { errors: @housing_reservation.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # PUT /housing_reservations/{id}
  def update
    @housing_reservation = find_housing_reservation
    unless @housing_reservation.update(housing_reservation_params)
      render json: { errors: @housing_reservation.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # DELETE /housing_reservations/{id}
  def destroy
    find_housing_reservation.destroy
  end

  private
  def find_user_housing_reservations
    User.find_by_id!(params[:user_id]).housing_reservations
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Housing adverts not found' }, :status => :not_found
  end

  def find_advert_housing_reservations
    HousingAdvert.find_by_id!(params[:housing_advert_id]).housing_reservations
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Housing adverts not found' }, :status => :not_found
  end

  def find_housing_reservation
    HousingReservation.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Reservation not found' }, :status => :not_found
  end

  def housing_reservation_params
    params.permit(
      :start_date, :end_date, :nb_persons, :status, :housing_advert_id, :user_id
    )
  end
end

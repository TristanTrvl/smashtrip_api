class HousingAdvertsController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_housing_advert, except: %i[create index]

  # GET /housing_advert
  def index
    @housing_adverts = HousingAdvert.all
    render json: @housing_adverts, status: :ok
  end

  # GET /user/{user_id}/housing_advert/{id}
  def show
    render json: @housing_adverts, status: :ok
  end

  # POST /user/{user_id}/housing_advert
  def create
    @housing_advert = HousingAdvert.new(housing_advert_params)
    if @housing_advert.save
      render json: @housing_advert, status: :created
    else
      render json: { errors: @housing_advert.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /user/{user_id}/housing_advert/{id}
  def update
    unless @housing_advert.update(housing_advert_params)
      render json: { errors: @housing_advert.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /user/{user_id}/housing_advert/{id}
  def destroy
    @housing_advert.destroy
  end

  private

  def find_housing_advert
    @housing_advert = HousingAdvert.find_by_id!(params[:_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def housing_advert_params
    params.permit(
      :start_date, :end_date, :event_id, :price, :desc, :user_id
    )
  end
end

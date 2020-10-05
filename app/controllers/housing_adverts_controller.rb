class HousingAdvertsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  before_action :find_housing_advert, except: [:index, :create]

  # GET /housing_adverts OR /user/{user_id}/housing_adverts
  def index
    if params[:user_id]
      @housing_adverts = find_user.housing_advert.all
    else 
      @housing_adverts = HousingAdvert.all
    end
    render json: @housing_adverts, status: :ok
  end
  
  # GET /housing_adverts/{id} OR /user/{user_id}/housing_adverts/{id}
  def show
    render json: @housing_advert, status: :ok
  end

  # POST /user/{user_id}/housing_adverts
  def create
    @housing_advert = HousingAdvert.new(housing_advert_params)
    if @housing_advert.save
      render json: @housing_advert, status: :created
    else
      render json: { errors: @housing_advert.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /user/{user_id}/housing_adverts/{id}
  def update
    unless @housing_advert.update(housing_advert_params)
      render json: { errors: @housing_advert.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /user/{user_id}/housing_adverts/{id}
  def destroy
    @housing_advert.destroy
  end

  private
  
  def find_user
    User.find_by_id!(params[:user_id])
  end

  def find_housing_advert
    if params[:user_id]
      @housing_advert = find_user.housing_advert.find_by_id!(params[:id])
    else
      @housing_advert = HousingAdvert.find_by_id!(params[:id])
    end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'House not found' }, status: :not_found
  end

  def housing_advert_params
    params.permit(
      :start_date, :end_date, :event_id, :price, :desc, :user_id
    )
  end
end

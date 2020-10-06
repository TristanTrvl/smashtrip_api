class HousingAdvertsController < ApplicationController
  before_action :authorize_request, :except => [:index, :show]

  # GET /housing_adverts OR /user/{user_id}/housing_adverts
  def index
    if params[:user_id]
      @housing_adverts = find_user_housing_adverts.all
    else 
      @housing_adverts = HousingAdvert.all
    end
    render json: @housing_adverts, :status => :ok
  end
  
  # GET /housing_adverts/{id} OR /user/{user_id}/housing_adverts/{id}
  def show
    if params[:user_id]
      @housing_advert = find_user_housing_adverts.find_by_id!(params[:id])
    else
      @housing_advert = find_housing_advert
    end
    render json: @housing_advert, :status => :ok
  end

  # POST /housing_adverts
  def create
    @housing_advert = HousingAdvert.new(housing_advert_params)
    if @housing_advert.save
      render json: @housing_advert, :status => :created
    else
      render json: { errors: @housing_advert.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # PUT /housing_adverts/{id}
  def update
    @housing_advert = find_housing_advert
    unless @housing_advert.update(housing_advert_params)
      render json: { errors: @housing_advert.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # DELETE /housing_adverts/{id}
  def destroy
    find_housing_advert.destroy
  end

  private
  def find_user_housing_adverts
    User.find_by_id!(params[:user_id]).housing_advert
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Housing adverts not found' }, :status => :not_found
  end

  def find_housing_advert
    HousingAdvert.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Housing advert not found' }, :status => :not_found
  end

  def housing_advert_params
    params.permit(
      :start_date, :end_date, :event_id, :price, :desc, :user_id
    )
  end
end

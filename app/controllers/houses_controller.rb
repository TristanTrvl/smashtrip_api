class HousesController < ApplicationController
  before_action :authorize_request
  before_action :find_house, except: :create
 
  # GET /users/{id}/house
  def show
    render json: @house, status: :ok
  end

  # POST /users/{id}/house
  def create
    @user = User.find(params[:user_id])
    @house = @user.create_house(house_params)
    if @house.save
      render json: @house, status: :created
    else
      render json: { errors: @house.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # PUT /users/{id}/house
  def update
    unless @house.update(house_params)
      render json: { errors: @house.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}/house
  def destroy
    @house.destroy
  end

  private
    def find_house
      @house = User.find_by_id!(params[:user__id]).house
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'House not found' }, status: :not_found
    end

    def house_params
      params.permit(:address, :nb_slots, :user_id)
    end
end

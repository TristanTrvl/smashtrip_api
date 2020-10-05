class HousesController < ApplicationController
  before_action :authorize_request
  before_action :find_house, except: :create
 
  # GET /users/{id}/house
  def show
    render json: @house.to_json(:include => :conveniences), status: :ok
  end

  # POST /users/{id}/house
  def create
    @user = User.find_by_id!(params[:user_id])
    @house = @user.build_house(house_params)
    handle_house_conveniences
    if @house.save
      render json: @house, status: :created
    else
      render json: { errors: @house.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # PUT /users/{id}/house
  def update
    @house.assign_attributes(house_params)
    handle_house_conveniences
    unless @house.save
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
      @house = User.find_by_id!(params[:user_id]).house
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'House not found' }, status: :not_found
    end
    
    def handle_house_conveniences
      if params['conveniences_ids']
        @house.conveniences.clear
        conveniences = params['conveniences_ids'].to_unsafe_h.map { |_, id| Convenience.find(id) }
        @house.conveniences << conveniences 
      end 
    end

    def house_params
      params.permit(:address, :nb_slots, :user_id)
    end
end

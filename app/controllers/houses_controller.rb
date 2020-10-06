class HousesController < ApplicationController
  before_action :authorize_request
   
  # GET /users/{user_id}/house
  def show
    render json: find_house.to_json(:include => :conveniences), :status => :ok
  end

  # POST /users/{user_id}/house
  def create
    @house = find_user.build_house(house_params)
    handle_house_conveniences
    if @house.save
      render json: @house, :status => :created
    else
      render json: { errors: @house.errors.full_messages },
            :status => :unprocessable_entity
    end
  end

  # PUT /users/{user_id}/house
  def update
    @house = find_house
    @house.assign_attributes(house_params)
    handle_house_conveniences
    unless @house.save
      render json: { errors: @house.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # DELETE /users/{user_id}/house
  def destroy
    find_house.destroy
  end

  private
    def find_user
      User.find_by_id!(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, :status => :not_found
    end

    def find_house
      find_user.house
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'House not found' }, :status => :not_found
    end
    
    def handle_house_conveniences
      if params['conveniences_ids']
        @house = find_house
        @house.conveniences.clear
        conveniences = params['conveniences_ids'].to_unsafe_h.map { |_, id| Convenience.find(id) }
        @house.conveniences << conveniences 
      end 
    end

    def house_params
      params.permit(:address, :nb_slots)
    end
end

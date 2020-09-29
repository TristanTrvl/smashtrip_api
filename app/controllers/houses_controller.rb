class HousesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @house = @user.create_house(house_params)
    render json: @house, status: :ok
  end
 
  private
    def house_params
      params.permit(:address, :nb_slots, :user_id)
    end
end

class UsersController < ApplicationController
  before_action :authorize_request, :except => :create

  # GET /users
  def index
    @users = User.all
    render json: @users.to_json(:include => {:house => {:include => :conveniences}}), :status => :ok
  end

  # GET /users/{id}
  def show
    render json: find_user.to_json(:include => {:house => {:include => :conveniences}}), :status => :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, :status => :created
    else
      render json: { errors: @user.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    @user = find_user
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    find_user.destroy
  end

  private

  def find_user
    User.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, :status => :not_found
  end

  def user_params
    params.permit(
      :email, :username, :password, :password_confirmation, :firstname, :name, :tel, :twitter, :discord
    )
  end
end
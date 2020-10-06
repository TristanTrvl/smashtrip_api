class ConveniencesController < ApplicationController
  before_action :authorize_request, :except => [:index,:show]

  # GET /conveniences
  def index
    @conveniences = Convenience.all
    render json: @conveniences, :status => :ok
  end

  # GET /conveniences/{id}
  def show
    render json: find_convenience, :status => :ok
  end

  # POST /conveniences
  def create
    @convenience = Convenience.new(convenience_params)
    if @convenience.save
      render json: @convenience, :status => :created
    else
      render json: { errors: @convenience.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # PUT /conveniences/{id}
  def update
    @convenience = find_convenience
    unless @convenience.update(convenience_params)
      render json: { errors: @convenience.errors.full_messages },
             :status => :unprocessable_entity
    end
  end

  # DELETE /conveniences/{id}
  def destroy
    find_convenience.destroy
  end

  private

  def find_convenience
    Convenience.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Convenience not found' }, :status => :not_found
  end

  def convenience_params
    params.permit(:name)
  end
end

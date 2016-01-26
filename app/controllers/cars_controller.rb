class CarsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_action:find_car, only: [:show,:edit,:update,:destroy]
	
	def index
		@cars = Car.all.order("created_at DESC")
	end

	def new
		@car = Car.new
		
	end

	def create
  		@car = Car.new(post_params)

  		if @car.save
      		render_succes
  		else 
  			render_request_wrong
		end
  	end

	def show
  	end

  	def edit                                                                                                                  
  	end

  	def update
  		if @car.update(post_params)
  	   		render_succes
  		else
  			render_request_wrong
  		end
  	end

	def destroy
		@car.destroy
		@car = Car.find_by_id params[:id]
    	if @car == nil
    		render_succes
    	else
    		render fail
    	end
  	end

  	private
  	def find_car    
  		@car = Car.find_by_id params[:id]
    	if @car == nil 
      		render_404
    	end
  	end

  	def post_params
  		params.require(:car).permit(:brand, :model, :year, :photo, :description)
  	end

  	def render_404
  		render json: { message: 'invalid_id' }, status: :unauthorized
    	
  	end

  	def render_request_wrong
  		render json: { message: 'wrong request' }, status: :unauthorized
  	end

  	def render_succes
  		render json: { message: 'succes' }
  	end

  	def render_fail
  		render json: { message: 'fail' }
  	end
end

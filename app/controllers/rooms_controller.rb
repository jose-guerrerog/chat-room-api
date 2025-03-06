class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render json: @rooms
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      render json: @room, status: :created
    else
      render json: { errors: @room.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def show
    @room = Room.find(params[:id])
    render json: @room, include: :messages
  end
  
  private
  
  def room_params
    params.permit(:name)
  end
end
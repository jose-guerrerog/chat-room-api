class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    
    if @message.save
      # Return the full message object in the response
      render json: @message, status: :created
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages.order(created_at: :asc).limit(50)
    render json: @messages
  end
  
  private
  
  def message_params
    params.permit(:content, :sender_name)
  end
end
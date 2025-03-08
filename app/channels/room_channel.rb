class RoomChannel < ApplicationCable::Channel
  def subscribed
    room_id = params[:room_id].to_s
    puts "SUBSCRIPTION: Client subscribed to room_#{room_id}"
    stream_from "room_#{room_id}"
  end

  def unsubscribed
    # Any cleanup needed
  end
  
  def speak(data)
    room_id = params[:room_id].to_s
    puts "SPEAK: Received data for room_#{room_id}: #{data.inspect}"
    
    # Simple message format
    message = {
      content: data['content'],
      sender_name: data['sender_name'],
      timestamp: Time.now.to_i
    }
    
    puts "BROADCAST: Sending to room_#{room_id}: #{message.inspect}"
    
    # Direct broadcasting without any model interactions
    ActionCable.server.broadcast("room_#{room_id}", message)
  end
end
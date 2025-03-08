class RoomChannel < ApplicationCable::Channel
  def subscribed
    room_id = params[:room_id]
    puts "Client subscribed to RoomChannel for room ID: #{room_id}"
    begin
      room = Room.find(room_id)
      stream_for room
      puts "Successfully subscribed to room: #{room.name}"
    rescue => e
      puts "Error subscribing to room: #{e.message}"
      reject
    end
  end

  def unsubscribed
    puts "Client unsubscribed from RoomChannel"
  end
  
  def speak(data)
    puts "Received speak action with data: #{data.inspect}"
    begin
      room_id = params[:room_id]
      room = Room.find_by(id: room_id)
      
      if room.nil?
        puts "Room not found with ID: #{room_id}"
        return
      end
      
      message = room.messages.create!(
        content: data['content'],
        sender_name: data['sender_name']
      )
      
      puts "Created message: #{message.inspect}"
      
      # Create a simple serialized message hash to avoid complex object serialization issues
      message_data = {
        id: message.id,
        content: message.content,
        sender_name: message.sender_name,
        created_at: message.created_at,
        room_id: room.id
      }
      
      # Use broadcast_to with proper error handling
      begin
        puts "Attempting to broadcast message to room: #{room.id}"
        RoomChannel.broadcast_to(room, message_data)
        puts "Successfully broadcast message"
      rescue => broadcast_error
        puts "Error during broadcast: #{broadcast_error.message}"
        puts broadcast_error.backtrace.join("\n")
        
        # Fallback to direct broadcasting if the broadcast_to method fails
        puts "Trying fallback broadcast method"
        ActionCable.server.broadcast("room_channel_#{room_id}", message_data)
      end
      
    rescue => e
      puts "Error in speak method: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
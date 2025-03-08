class RoomChannel < ApplicationCable::Channel
  def subscribed
    room_id = params[:room_id]
    puts "Client subscribed to RoomChannel for room ID: #{room_id}"
    
    # Use a simple string-based stream instead of stream_for
    stream_from "room_#{room_id}"
    puts "Successfully subscribed to room channel: #{room_id}"
    
  rescue => e
    puts "Error subscribing to room: #{e.message}"
    reject
  end

  def unsubscribed
    puts "Client unsubscribed from RoomChannel"
  end
  
  def speak(data)
    puts "Received speak action with data: #{data.inspect}"
    begin
      room_id = params[:room_id]
      
      # Skip finding the room by ID for broadcasting purposes
      # Instead, just create the message using the room_id directly
      message = Message.create!(
        content: data['content'],
        sender_name: data['sender_name'],
        room_id: room_id
      )
      
      puts "Created message: #{message.inspect}"
      
      # Create a simple message hash
      message_data = {
        id: message.id,
        content: message.content,
        sender_name: message.sender_name,
        created_at: message.created_at,
        room_id: room_id
      }
      
      # Use a simple string identifier that doesn't depend on finding the room
      channel_name = "room_#{room_id}"
      puts "Broadcasting directly to channel: #{channel_name}"
      ActionCable.server.broadcast(channel_name, message_data)
      puts "Broadcast attempt completed"
      
    rescue => e
      puts "Error in speak method: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
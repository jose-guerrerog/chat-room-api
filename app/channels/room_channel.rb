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
      room = Room.find(params[:room_id])
      
      message = room.messages.create!(
        content: data['content'],
        sender_name: data['sender_name']
      )
      
      puts "Created message: #{message.inspect}"
    rescue => e
      puts "Error in speak method: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
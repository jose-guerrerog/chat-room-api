class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Make sure we're broadcasting a complete message object with all attributes
    message_json = message.as_json
    puts "Broadcasting message: #{message_json.inspect}" # Debug logging
    
    # Broadcast message to all clients subscribed to this room
    begin
      RoomChannel.broadcast_to(message.room, message_json)
      puts "Successfully broadcast message to room #{message.room.id}"
    rescue => e
      puts "Error broadcasting message: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
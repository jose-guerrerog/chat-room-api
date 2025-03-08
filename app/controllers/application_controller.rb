class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  skip_before_action :verify_authenticity_token
  allow_browser versions: :modern

  def test_broadcast
    room_id = params[:room_id]
    message = {
      content: "Test message from server #{Time.now}",
      sender_name: "Server",
      timestamp: Time.now.to_i
    }
    ActionCable.server.broadcast("room_#{room_id}", message)
    render plain: "Broadcast sent to room_#{room_id}"
  end
end

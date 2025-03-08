class DebugController < ApplicationController
  def routes
    routes_info = Rails.application.routes.routes.map do |route|
      {
        path: route.path.spec.to_s,
        verb: route.verb,
        controller: route.defaults[:controller],
        action: route.defaults[:action]
      }
    end
    
    render json: routes_info
  end
end
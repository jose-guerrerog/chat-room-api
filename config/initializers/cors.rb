Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['REACT_APP_URL']
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false
  end
end
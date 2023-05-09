Rails.application.routes.draw do
  get "weather/index"
  get "weather/:zip", to: "weather#show", as: "show_weather"

  root "weather#index"
end

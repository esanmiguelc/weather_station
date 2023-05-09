Rails.application.routes.draw do
  get "weather/index"
  post "weather/search", to: "weather#search", as: "search_weather"
  get "weather/:zip", to: "weather#show", as: "show_weather"

  root "weather#index"
end

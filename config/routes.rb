Rails.application.routes.draw do
  get "weather/index"
  get "weather/:zip", to: "weather#show"

  root "weather#index"
end

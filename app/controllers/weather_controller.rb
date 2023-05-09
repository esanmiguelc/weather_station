class WeatherController < ApplicationController
  def index
  end

  def show
  end

  def search
    redirect_to show_weather_path(60647)
  end
end

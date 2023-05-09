class WeatherController < ApplicationController


  def index
  end

  def show
    @weather = FetchForecast.for(params[:zip]).value
  end

  def search
    redirect_to show_weather_path(60647)
  end
end

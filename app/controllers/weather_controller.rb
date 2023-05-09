class WeatherController < ApplicationController


  def index
  end

  def show
    result = FetchForecast.for(params[:zip])
    if result.errors?
      redirect_to root_path, alert: result.errors
    else
      @weather = result.value
    end
  end

  def search
    result = AddressValidator.validate(params[:location])
    if result.errors?
      redirect_to root_path, alert: result.errors
    else
      redirect_to show_weather_path(result.value.zip)
    end
  end
end

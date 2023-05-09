class WeatherService
  WEATHER_API_URL_BASE = "http://api.weatherapi.com/v1"

  def self.fetch(zip)
    forecast_url = "#{WEATHER_API_URL_BASE}/forecast.json?key=#{WEATHER_API_KEY}&q=#{zip}&days=3"

    response = Typhoeus.get(forecast_url)
    return Result.fail("Unable to fetch weather") unless response.success?

    forecast_response = JSON.parse(response.body)

    Result.success(
      WeatherResult.new(
        forecast_response['location']['name'],
        Forecast.new(
          forecast_response['forecast']['forecastday'][0]['day']['maxtemp_f'],
          forecast_response['forecast']['forecastday'][0]['day']['mintemp_f'],
          forecast_response['current']['temp_f'],
          DateTime.now
        ),
        forecast_response['forecast']['forecastday'][0..2].map do |day|
          Forecast.new(
            day['day']['maxtemp_f'],
            day['day']['mintemp_f'],
            day['day']['avgtemp_f'],
            DateTime.parse(day['date']),
          )
        end,
        response.cached?
      )
    )
  end

  private

  WEATHER_API_KEY = ENV["WEATHER_API_KEY"]
end

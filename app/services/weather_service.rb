class WeatherService
  WEATHER_API_URL_BASE = "http://api.weatherapi.com/v1"

  def self.fetch(zip)
    forecast_url = "#{WEATHER_API_URL_BASE}/forecast.json?key=#{WEATHER_API_KEY}&q=#{zip}&days=3"

    response = Typhoeus.get(forecast_url, cache_ttl: CACHE_TTL)
    if response.success?
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
    else
      # We were not able to make a successful call so log a warning so that it can be looked into.
      Rails.logger.warn("The Weather API response failed with code: #{response.code}")
      Result.fail(:weather_api_failure)
    end
  end

  private

  WEATHER_API_KEY = ENV["WEATHER_API_KEY"]
  CACHE_TTL = 30.minutes.in_seconds
end

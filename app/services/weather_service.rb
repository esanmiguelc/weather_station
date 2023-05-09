class WeatherService

  def self.fetch(zip)
      Result.success(WeatherResult.new(
        "Chicago",
        Forecast.new(10, 5, 7, DateTime.now),
        [
          Forecast.new(10, 5, 7, DateTime.now + 1.day),
          Forecast.new(10, 5, 7, DateTime.now + 2.day),
          Forecast.new(10, 5, 7, DateTime.now + 3.day)
        ],
        true
      ))
  end
end

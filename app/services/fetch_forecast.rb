class FetchForecast

  def self.for(zip)
    if valid?(zip)
      WeatherService.fetch(zip)
    else
      Result.fail("Invalid zip")
    end
  end

  def self.valid?(zip)
    zip.length == 5
  end
end

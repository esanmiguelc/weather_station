class FetchForecast

  def self.for(zip)
    # If zip is invalid, no point in even trying to fetch
    return Result.fail("Invalid zip") unless valid?(zip)

    WeatherService.fetch(zip)
  end

  def self.valid?(zip)
    zip.length == 5
  end
end

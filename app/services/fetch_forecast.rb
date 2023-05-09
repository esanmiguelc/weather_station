class FetchForecast

  def self.for(zip)
    # If zip is invalid, no point in even trying to fetch
    validation_result = AddressValidator.validate(zip)
    return validation_result if validation_result.errors?

    WeatherService.fetch(validation_result.value.zip)
  end

  def self.valid?(zip)
    zip.length == 5
  end
end

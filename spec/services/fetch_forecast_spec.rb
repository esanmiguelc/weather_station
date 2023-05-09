require 'rails_helper'

describe FetchForecast do

  it "returns a result with an error if the zip is wrong" do
    result = FetchForecast.for("")
    expect(result.errors?).to be true
  end

  it "returns no errors with a valid zip code" do
    result = FetchForecast.for("60647")
    expect(result.errors?).to be false
  end

  it "returns the error from the weather service if it fails" do
    result = Result.fail("Failure")
    expect(WeatherService).to receive(:fetch).and_return(result)

    forecast = FetchForecast.for("60647")

    expect(forecast).to eq(result)
  end

  it "returns the forecast from the weather service if it is successful" do
    result = Result.success(WeatherResult.new(
      "Chicago",
      Forecast.new(10, 5, 7, DateTime.now),
      [
        Forecast.new(10, 5, 7, DateTime.now + 1.day),
        Forecast.new(10, 5, 7, DateTime.now + 2.day),
        Forecast.new(10, 5, 7, DateTime.now + 3.day)
      ],
      true
    ))
    expect(WeatherService).to receive(:fetch).and_return(result)

    forecast = FetchForecast.for("60647")

    expect(forecast).to eq(result)
  end
end

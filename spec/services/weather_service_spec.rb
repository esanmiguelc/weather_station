require 'rails_helper'

describe WeatherService do
  before do
    Typhoeus::Expectation.clear
  end

  it "returns an error result when the call fails" do
    response = Typhoeus::Response.new(code: 500)
    Typhoeus.stub(/#{WeatherService::WEATHER_API_URL_BASE}/).and_return(response)

    result = WeatherService.fetch("60647")
    expect(result.errors?).to eq(true)
  end

  it "returns a success result with the mapped data" do
    response = Typhoeus::Response.new(code: 200, body: File.read(Rails.root.join("spec", "forecast_response.json")))
    Typhoeus.stub(/#{WeatherService::WEATHER_API_URL_BASE}/).and_return(response)

    result = WeatherService.fetch("60647")
    expect(result.errors?).to eq(false)
    expect(result.value).to be_instance_of(WeatherResult)
  end
end

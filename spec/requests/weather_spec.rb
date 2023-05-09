require 'rails_helper'

RSpec.describe "Weather", type: :request do
  let(:sample_weather_result) do
    WeatherResult.new(
      "Chicago",
      Forecast.new(10, 5, 7, DateTime.now),
      [
        Forecast.new(10, 5, 7, DateTime.now + 1.day),
        Forecast.new(10, 5, 7, DateTime.now + 2.day),
        Forecast.new(10, 5, 7, DateTime.now + 3.day)
      ],
      true
    )
  end

  describe "GET /index" do
    it "returns http success" do
      get "/weather/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      result = Result.success(sample_weather_result)
      expect(FetchForecast).to receive(:for).and_return(result)

      get "/weather/show"

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /search" do
    it "redirects to show on valid zip" do
      post "/weather/search", params: { location: "My location, 60647" }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(show_weather_path(60647))
    end
  end
end

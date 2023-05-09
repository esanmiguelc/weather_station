require 'rails_helper'

RSpec.describe "Weather", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/weather/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
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

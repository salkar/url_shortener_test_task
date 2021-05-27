# frozen_string_literal: true

RSpec.describe Urls::StatsController, type: :request do
  describe "GET /urls/:id/stats" do
    let(:open_count) { 13 }
    let!(:url_object) { create(:url, open_count: open_count) }

    subject do
      get("/urls/#{url_object.slug}/stats",
          headers: { "CONTENT_TYPE" => "application/json" })
    end

    it "should return full url" do
      subject
      expect(response.status).to eq(200)
      expect(json_body).to eq("data" => { "open_count" => open_count })
    end
  end
end

# frozen_string_literal: true

RSpec.describe UrlsController, type: :request do
  describe "POST /urls" do
    let(:params) { { "url" => "https://some-url.com" } }
    let(:service_double) { double("Urls::Create") }
    let(:success_result) { true }
    let!(:url_object) { create(:url) }
    let(:url_object_result) { url_object }
    let(:errors_details) { { "url" => [{ "error" => "blank" }] } }
    let(:errors_result) do
      obj = double("ActiveModel::Errors")
      allow(obj).to receive(:details).and_return(errors_details)
      obj
    end

    subject do
      post("/urls",
           params: params.to_json,
           headers: { "CONTENT_TYPE" => "application/json" })
    end

    before do
      allow(Urls::Create)
        .to receive(:new).and_return(service_double)
      allow(service_double)
        .to receive(:url_object)
        .and_return(url_object_result)
      allow(service_double).to receive(:perform)
      allow(service_double)
        .to receive(:success)
        .and_return(success_result)
      allow(service_double)
        .to receive(:errors)
        .and_return(errors_result)
    end

    it "should work" do
      subject
      expect(response.status).to eq(201)
      expect(json_body)
        .to eq("data" => { "short_url" => url_url(url_object.slug) })
    end

    it "should use service correctly" do
      subject
      expect(Urls::Create).to have_received(:new).with(url: params["url"])
    end

    context "on validation error" do
      let(:success_result) { false }

      it "should return errors" do
        subject
        expect(response.status).to eq(422)
        expect(json_body).to eq("errors" => errors_details)
      end
    end
  end

  describe "GET /urls/:id" do
    let!(:url_object) { create(:url) }

    subject do
      get("/urls/#{url_object.slug}",
          headers: { "CONTENT_TYPE" => "application/json" })
    end

    it "should return full url" do
      subject
      expect(response.status).to eq(200)
      expect(json_body)
        .to eq("data" => { "url" => url_object.url })
    end

    it "should increment counter" do
      expect { subject }.to change {
 url_object.reload.open_count }.from(0).to(1)
    end
  end
end

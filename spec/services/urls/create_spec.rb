# frozen_string_literal: true

RSpec.describe Urls::Create do
  let(:url) { "https://github.com/" }
  subject { described_class.new(url: url) }

  it "should be success" do
    subject.perform
    expect(subject.success).to be_truthy
  end

  context "url object" do
    it "should be correct" do
      expect { subject.perform }.to change { Url.count }.from(0).to(1)
      expect(subject.url_object.slug).to be_truthy
      expect(subject.url_object.url).to eq(url)
      expect(subject.url_object.open_count).to eq(0)
    end
  end

  context "multiple urls" do
    it "should have different slugs" do
      subject.perform
      second_service = described_class.new(url: "https://another-url.com/")
      expect { second_service.perform }.to change { Url.count }.from(1).to(2)
      expect(subject.url_object.slug).not_to eq(second_service.url_object.slug)
    end
  end

  context "validations" do
    let(:url) { nil }

    it "should work" do
      subject.perform
      expect(subject.success).to be_falsey
      expect(subject.errors.details).to eq(url: [{ error: :blank }])
    end
  end
end

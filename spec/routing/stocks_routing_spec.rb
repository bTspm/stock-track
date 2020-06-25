require "rails_helper"

describe StocksController do
  let(:base_url) { "/stocks" }
  let(:controller) { "stocks" }

  describe "#earnings" do
    let(:action) { "earnings" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#growth" do
    let(:action) { "growth" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#home" do
    let(:action) { "home" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#information" do
    let(:action) { "information" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#news" do
    let(:action) { "news" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#quote" do
    let(:action) { "quote" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#stats" do
    let(:action) { "stats" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#recommendation_trends" do
    let(:action) { "recommendation_trends" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end

  describe "#time_series" do
    let(:action) { "time_series" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end
end

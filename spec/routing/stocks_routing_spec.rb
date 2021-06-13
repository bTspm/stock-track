require "rails_helper"

describe StocksController do
  let(:base_url) { "/stocks" }
  let(:controller) { "stocks" }

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

  describe "#time_series" do
    let(:action) { "time_series" }
    subject { get("#{base_url}/#{action}") }

    it { is_expected.to route_to(controller: controller, action: action) }
  end
end

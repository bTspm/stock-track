require "rails_helper"

describe ExchangesPresenter do
  describe ".scalar" do
    let(:country) { double(:country, code: "ABC", alpha2: "AB") }
    let(:name) { "Name" }
    let(:object) { double(:object, country: country, name: name) }
    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#name_with_country_code" do
      subject { presenter.name_with_country_code }

      it "expect to return country and name" do
        expect(subject).to eq "Name - (ABC)"
      end
    end
  end
end

require "rails_helper"

describe ExchangesPresenter do
  describe ".scalar" do
    let(:country) { "Country" }
    let(:name) { "Name" }
    let(:object) { double(:object, country: country, name: name) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#name_with_country" do
      subject { presenter.name_with_country }

      it "expect to return country and name" do
        expect(subject).to eq "Name - (Country)"
      end
    end
  end
end

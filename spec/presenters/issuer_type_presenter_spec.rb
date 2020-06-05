require "rails_helper"

describe IssuerTypesPresenter do
  describe ".scalar" do
    let(:code) { "Code" }
    let(:name) { "Name" }
    let(:object) { double(:object, code: code, name: name) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#name_with_code" do
      subject { presenter.name_with_code }

      it "expect to return code and name" do
        expect(subject).to eq "Name - (Code)"
      end
    end
  end
end

require "rails_helper"

describe Utils do
  class DummyClass
    include Utils

    alias_method :h, :view_context
  end

  subject(:dummy_class) { DummyClass.new }

  describe "#value_or_na" do
    let(:value) { double(:vslue) }

    subject { dummy_class.value_or_na(value) }

    context "without value" do
      let(:value) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with value" do
      it { is_expected.to eq value }
    end
  end
end

require "rails_helper"

describe Entities::ExternalAnalyses::Analysis do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      analysts_count: analysts_count,
      custom: custom,
      original_rating: original_rating,
      price_target: price_target,
      rating_rank: rating_rank,
      source: source,
      url: url,
    }
  end
  let(:analysts_count) { double(:analysts_count) }
  let(:custom) { double(:custom) }
  let(:original_rating) { double(:original_rating) }
  let(:price_target) { double(:price_target) }
  let(:rating_rank) { double(:rating_rank) }
  let(:source) { double(:source) }
  let(:url) { double(:url) }
  let(:analysis) { described_class.new(args) }

  describe ".from_data_hash" do
    let(:custom_class) { double(:custom_class) }
    subject { described_class.from_data_hash(data_hash) }

    context "when analysis data hash has values" do
      let(:price_target_args) { {low: 100, average: 200, high: 300} }
      let(:data_hash) do
        {
          analysts_count: "analysts_count",
          custom: "custom",
          original_rating: "original_rating",
          price_target: price_target_args,
          rating_rank: "rating_rank",
          source: "source",
          url: "url"
        }
      end

      it "expect to initialize " do
        input_args = {
          analysts_count: "analysts_count",
          custom: "custom",
          original_rating: "original_rating",
          price_target: "Price Target",
          rating_rank: "rating_rank",
          source: "source",
          url: "url"
        }
        expect(OpenStruct).to receive(:new).with(price_target_args) { "Price Target" }
        expect(described_class).to receive(:new).with(input_args) { "Analysis" }

        expect(subject).to eq "Analysis"
      end
    end

    context "when analysis data hash does not have values" do
      let(:data_hash) { {} }

      it "expect to initialize analysis with empty values" do
        input_args = {
          analysts_count: nil,
          custom: nil,
          original_rating: nil,
          price_target: nil,
          rating_rank: nil,
          source: nil,
          url: nil
        }
        expect(described_class).to receive(:new).with(input_args) { "Analysis" }

        expect(subject).to eq "Analysis"
      end
    end
  end

  describe ".null_object_with_source" do
    subject { described_class.null_object_with_source("source") }

    it "expect to initialize analysis with passed in source" do
      expect(described_class).to receive(:new).with({ source: "source" }) { "Analysis" }

      expect(subject).to eq "Analysis"
    end
  end

  describe "#initialize" do
    context "when there is no rating_rank in args" do
      let(:args_without_ratings_rank) do
        args_without_ratings_rank = args
        args_without_ratings_rank[:source] = "source_abc"
        args_without_ratings_rank.delete(:rating_rank)
        args_without_ratings_rank
      end
      let(:mapping) { { source_abc: ratings }.with_indifferent_access }
      subject { described_class.new(args_without_ratings_rank).rating_rank }

      before do
        stub_const("Entities::ExternalAnalyses::RatingMappings::SOURCE_AND_RATING_MAPPING", mapping)
      end

      context "when rating mappings are available for source" do
        context "when original_rating is strong_buy" do
          let(:ratings) { { strong_buy: [original_rating] } }
          
          it { is_expected.to eq 1 }
        end

        context "when original_rating is buy" do
          let(:ratings) { { buy: [original_rating] } }
          
          it { is_expected.to eq 2 }
        end

        context "when original_rating is hold" do
          let(:ratings) { { hold: [original_rating] } }

          it { is_expected.to eq 3 }
        end

        context "when original_rating is sell" do
          let(:ratings) { { sell: [original_rating] } }

          it { is_expected.to eq 4 }
        end

        context "when original_rating is strong_sell" do
          let(:ratings) { { strong_sell: [original_rating] } }

          it { is_expected.to eq 5 }
        end

        context "when original_rating is not in any mapped value" do
          let(:ratings) { { abc: [original_rating] } }

          it { is_expected.to be_nil }
        end
      end

      context "when rating mappings are not available for source" do
        let(:ratings) { {} }

        it { is_expected.to be_nil }
      end
    end
  end

  describe "#basic?" do
    subject { analysis.basic? }

    context "when custom is blank" do
      let(:custom) { nil }

      it { is_expected.to eq false }
    end

    context "when price_target is blank" do
      let(:price_target) { nil }

      it { is_expected.to eq false }
    end

    context "when both custom and price_target are blank" do
      let(:custom) { nil }
      let(:price_target) { nil }

      it { is_expected.to eq true }
    end

    context "when both custom and price_target are not blank" do
      it { is_expected.to eq false }
    end
  end
end

require "rails_helper"

describe Scraper::GithubClient do
  let!(:conn) { double(:conn) }
  subject(:client) { described_class.new }

  before { allow(Faraday).to receive(:new) { conn } }

  describe "#snp500_symbols" do
    subject { client.snp500_symbols }

    it "expect to get snp500_symbols" do
      expect(client).to receive(:get).with(
        "https://raw.githubusercontent.com/datasets/s-and-p-500-companies/master/data/constituents_symbols.txt"
      ) { "Symbols" }

      expect(subject).to eq "Symbols"
    end
  end
end

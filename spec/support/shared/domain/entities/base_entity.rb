shared_examples_for "Entities::BaseEntity#initialize" do
  subject { described_class.new(args) }

  it { is_expected.to be_kind_of described_class }

  context "properties" do
    it "expect to create an object" do
      described_class::ATTRIBUTES.each do |key|
        expect(subject.send(key)).to eq args[key]
      end
    end
  end
end

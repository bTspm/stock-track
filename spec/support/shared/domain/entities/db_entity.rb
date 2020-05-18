shared_examples_for 'Entities::DbEntity.from_db_entity' do
  let(:attributes) { {test: 123} }
  let(:entity) { double(:entity, attributes: attributes) }

  subject { described_class.from_db_entity(entity) }

  context "without entity" do
    let(:entity) { nil }

    it { is_expected.to be_nil }
  end

  context "with entity" do
    it "expect to create entity with the attributes" do
      expect(described_class).to receive(:new).with(attributes) { "Entity" }

      expect(subject).to eq "Entity"
    end
  end
end

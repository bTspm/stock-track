shared_examples_for "Entities::HasDbEntity.from_db_entity" do |input_args|
  let(:attributes) { { id: 123 } }
  let(:entity) { double(:entity, attributes: attributes, errors: errors) }
  let(:error) { double(:error) }
  subject { described_class.from_db_entity(entity) }

  context "without entity" do
    let(:entity) { nil }
    it { is_expected.to be_nil }
  end

  context "with entity" do
    let(:errors) { [] }
    it "expect to create entity with the attributes" do
      input_args ||= { id: 123 }
      expect(described_class).to receive(:new).with(input_args) { "Entity" }

      expect(subject).to eq "Entity"
    end

    context "errors" do
      subject { described_class.from_db_entity(entity).errors }
      context "with errors" do
        let(:errors) { [error] }
        it { is_expected.to eq errors }
      end

      context "without errors" do
        let(:errors) { [] }
        it { is_expected.to be_nil }
      end
    end

    context "properties" do
      it { is_expected.to respond_to :created_at }
      it { is_expected.to respond_to :updated_at }
    end
  end
end

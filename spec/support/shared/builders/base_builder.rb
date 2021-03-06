shared_examples_for "BaseBuilder#initialize" do
  let(:db_entity) { double(:db_entity) }

  subject { described_class.new(db_entity) }

  context "properties" do
    context "with argument" do
      it "expect not to call initialize model" do
        subject
      end
    end

    context "without argument" do
      let(:db_entity) { nil }

      it "expect to to call _model_class and initialize" do
        expect_any_instance_of(described_class).to receive(:_model_class).and_call_original

        subject
      end
    end
  end
end

shared_examples_for "BaseBuilder#build" do
  let(:db_entity) { double(:db_entity) }

  subject { described_class.new(db_entity).build { puts "ABC" } }

  it "expect to yield and return the passed entity" do
    expect(STDOUT).to receive(:puts).with("ABC")

    expect(subject).to eq db_entity
  end
end

shared_examples_for "BaseBuilder#build_base_entity_from_domain" do
  let!(:builder) { described_class.new(db_entity) }
  let(:db_entity) { OpenStruct.new(test: "ABC") }
  let(:domain_entity) { double(:domain_entity) }
  subject { builder.build_base_entity_from_domain(domain_entity).test }

  it "expect to assign attribute values to db_entity" do
    expect(builder).to receive(:_base_column_names) { %i[test] }
    expect(domain_entity).to receive(:test) { "XYZ" }

    expect(subject).to eq "XYZ"
  end
end

shared_examples_for "BaseBuilder#build_base_entity_from_params" do
  let!(:builder) { described_class.new(db_entity) }
  let(:domain_entity) { double(:domain_entity) }
  let(:params) { { test: "XYZ" } }
  subject { builder.build_base_entity_from_params(params).test }

  it "expect to assign params to db_entity" do
    expect(builder).to receive(:_base_column_names) { %i[test] }

    expect(subject).to eq "XYZ"
  end
end

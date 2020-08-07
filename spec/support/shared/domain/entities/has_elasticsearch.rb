shared_examples_for "Entities::HasElasticsearch.from_es_response" do |input_args|
  let!(:response) { json_fixture("/elasticsearch_response/company.json") }
  subject { described_class.from_es_response(response) }

  it "expect to create entity with the attributes" do
    expect(described_class).to receive(:new).with(hash_including(input_args)) { "Entity" }

    expect(subject).to eq "Entity"
  end
end

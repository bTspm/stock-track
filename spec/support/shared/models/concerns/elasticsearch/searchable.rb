shared_examples_for "Elasticsearch::Searchable#add_alias" do
  let(:client) { double(:client) }
  let(:index_name) { "ABC" }
  subject { described_class.new.add_alias(index_name) }

  it "expect to call elasticsearch client and add alias" do
    expect(client).to receive_message_chain(:indices, :update_aliases).with(alias_body) { "Added Alias" }

    expect(subject).to eq "Added Alias"
  end
end

shared_examples_for "Elasticsearch::Searchable#all_indices_by_alias" do
  let(:client) { double(:client) }
  subject { described_class.new.all_indices_by_alias }

  before { expect(client).to receive_message_chain(:indices, :get_alias) { indices } }

  context "indicies with alias" do
    let(:indices) { index_with_alias }

    it { is_expected.to eq indices.keys }
  end

  context "indices without alias" do
    let(:indices) { index_without_alias }

    it { is_expected.to eq [] }
  end
end

shared_examples_for "Elasticsearch::Searchable#bulk_index" do
  let(:body) { "ABC" }
  let(:client) { double(:client) }
  subject { described_class.new.bulk_index(body) }

  before { expect(client).to receive(:bulk).with({ body: body }) { response } }

  context "with error" do
    let(:response) { { errors: "No Index" } }
    it "expect to log error and return response" do
      expect(Rails).to receive_message_chain(:logger, :error).with(
        "[ElasticSearch] Failed to bulk {\"errors\"=>\"No Index\"}"
      ) { "Logged" }

      expect(subject).to include(response)
    end
  end

  context "without errors" do
    let(:response) { { status: "success" } }
    it { is_expected.to include(response) }
  end
end

shared_examples_for "Elasticsearch::Searchable#create_index" do
  let(:body) { "ABC" }
  let(:client) { double(:client) }
  let(:searchable_class) { described_class.new }
  subject { searchable_class.create_index(index_name) }

  before do
    expect(searchable_class).to receive(:_mappings_and_settings) { "Mappings & Settings" }
    expect(client).to receive_message_chain(:indices, :create).with(create_args) { "Created" }
    expect(searchable_class).to receive(:add_alias) { "Alias Added" }
  end

  context "with index_name" do
    let(:create_args) { { body: "Mappings & Settings", index: index_name } }
    let(:index_name) { "index_name" }

    it "expect to create index with provided name" do
      expect(subject).to eq "Alias Added"
    end
  end

  context "without index_name" do
    let(:create_args) { { body: "Mappings & Settings", index: "#{index_alias}-Current Time" } }
    let(:index_name) { nil }

    it "expect to create index with generated name" do
      expect(Time).to receive_message_chain(:now, :to_i) { "Current Time" }

      expect(subject).to eq "Alias Added"
    end
  end
end

shared_examples_for "Elasticsearch::Searchable#delete_index" do
  let(:client) { double(:client) }
  let(:index_name) { double(:index_name) }
  subject { described_class.new.delete_index(index_name) }

  it "expect to delete index" do
    expect(client).to receive_message_chain(:indices, :delete).with({ index: index_name }) { "Deleted" }

    expect(subject).to eq "Deleted"
  end
end

shared_examples_for "Elasticsearch::Searchable#delete_all_indices_by_alias" do
  let(:searchable_class) { described_class.new }
  subject { searchable_class.delete_all_indices_by_alias }

  it "expect to delete all indices" do
    expect(searchable_class).to receive(:all_indices_by_alias) { "All indices" }
    expect(searchable_class).to receive(:delete_index).with("All indices") { "Deleted" }

    expect(subject).to eq "Deleted"
  end
end

shared_examples_for "Elasticsearch::Searchable#indices_list" do
  let(:client) { double(:client) }
  subject { described_class.new.indices_list }

  it "expect to retrieve all indices" do
    expect(client).to receive_message_chain(:indices, :get).with({ index: "_all" }) { "All Indices" }

    expect(subject).to eq "All Indices"
  end
end

shared_examples_for "Elasticsearch::Searchable#reindex" do
  let(:args) do
    {
      body: {
        source: { index: source },
        dest: { index: "#{index_alias}-Current Time" }
      },
      wait_for_completion: false
    }
  end
  let(:client) { double(:client) }
  let(:source) { double(:source) }
  subject { described_class.new.reindex(source) }

  it "expect to reindex to new index" do
    expect(Time).to receive_message_chain(:now, :to_i) { "Current Time" }
    expect(client).to receive(:reindex).with(args) { "Re-indexed" }

    expect(subject).to eq "Re-indexed"
  end
end

shared_examples_for "Elasticsearch::Searchable#remove_alias" do
  let(:client) { double(:client) }
  let(:index_name) { "ABC" }
  subject { described_class.new.remove_alias(index_name) }

  it "expect to call elasticsearch client and remove alias" do
    expect(client).to receive_message_chain(:indices, :update_aliases).with(alias_body) { "Removed Alias" }

    expect(subject).to eq "Removed Alias"
  end
end

shared_examples_for "Elasticsearch::Searchable#search" do
  let(:client) { double(:client) }
  let(:query) { double(:query) }
  let(:response) { { hits: { hits: [{ _source: "Search result" }] } } }
  subject { described_class.new.search(query: query, options: options) }

  before { expect(client).to receive(:search).with(payload) { response } }

  context "with options" do
    let(:index_name) { "index_name" }
    let(:options) { { index: index_name, size: size } }
    let(:payload) { { index: index_name, size: size, body: query } }
    let(:size) { 200 }
    it { is_expected.to eq ["Search result"] }
  end

  context "without options" do
    let(:options) { {} }
    let(:payload) { { index: index_alias, size: default_limit, body: query } }
    it { is_expected.to eq ["Search result"] }
  end
end

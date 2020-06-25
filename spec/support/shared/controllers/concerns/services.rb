shared_examples_for "Services#company_service" do
  subject { described_class.new.company_service }

  it "expect to initialize company_service" do
    expect(CompanyService).to receive(:new) { "company_service"}
    
    expect(subject).to eq "company_service"
  end
end

shared_examples_for "Services#stock_service" do
  subject { described_class.new.stock_service }

  it "expect to initialize stock_service" do
    expect(StockService).to receive(:new) { "stock_service"}

    expect(subject).to eq "stock_service"
  end
end

puts "Started Seeding - Issuer Types"

issuer_types = {
 ad: "ADR",
 ce: "Closed end fund",
 cef: "Closed Ended Fund",
 cs: "Common Stock",
 et: "ETF",
 lp: "Limited Partnerships",
 na: "N/A",
 oef: "Open Ended Fund",
 ps: "Preferred Stock",
 re: "REIT",
 si: "Secondary Issue",
 temp: "Temporary",
 ut: "Unit",
 wt: "Warrant"
}

issuer_types.each do |code, name|
  IssuerType.find_or_create_by(code: code.to_s.upcase) do |issuer_type|
    issuer_type.name = name
  end
end
puts "Completed Seeding - Issuer Types"

puts "=========================================================="

puts "Started Seeding - Exchange"
Services::StockService.new.create_or_update_exchanges
puts "Completed Seeding - Exchange"

puts "=========================================================="

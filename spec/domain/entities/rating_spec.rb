require "rails_helper"

describe Entities::Rating do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      rating: rating,
      source: source
    }
  end
  let(:rating) { double(:rating) }
  let(:source) { double(:source) }
end

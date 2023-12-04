require 'rails_helper'

RSpec.describe Toy, type: :model do
  it "should validate name" do
    toy = Toy.create(cat_id: 1)
    expect(toy.errors[:name]).to_not be_empty
  end
  it "should validate cat_id" do
    toy = Toy.create(name: 'Toy Mouse')
    expect(toy.errors[:cat_id]).to_not be_empty
  end
end

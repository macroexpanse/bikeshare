require_relative '../spec_helper'
require_relative '../../lib/models/bike'

describe 'Bike model' do
  before do
    @bike = Bike.create(available: true)
  end

  it 'is available' do
    expect(@bike.available).to eq(true)
  end
end

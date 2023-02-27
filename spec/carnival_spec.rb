require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new(8)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival).to be_a Carnival
      expect(@carnival.duration_days).to eq(8)
      expect(@carnival.rides).to eq([])
    end
  end

  describe '#add_ride' do
    it 'can add a ride to rides array' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
    end
  end
end

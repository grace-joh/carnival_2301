require 'spec_helper'

RSpec.describe Ride do
  before(:each) do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ride1).to be_a Ride
      expect(@ride1.name).to eq('Carousel')
      expect(@ride1.min_height).to eq(24)
      expect(@ride1.admission_fee).to eq(1)
      expect(@ride1.excitement).to eq(:gentle)
      expect(@ride1.total_revenue).to eq(0)
    end
  end

  describe '#board_rider for ride1' do
    before(:each) do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    end

    it 'adds rider to the rider log' do
      expect(@ride1.rider_log).to eq({ @visitor1 => 2, @visitor2 => 1 })
    end

    it 'subtracts the admission fee from the riders spending money' do
      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end

    it 'calculates the rides total revenue' do
      expect(@ride1.total_revenue).to eq(3)
    end

    it 'boards rider only if they have enough spending money' do
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)

      expect(@ride1.rider_log).to eq({ @visitor1 => 2, @visitor2 => 5 })
    end
  end

  describe '#board_rider for ride3' do
    before(:each) do
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
    end

    it 'does not board a rider who is too short to ride, or whose preference doesnt match the ride' do
      expect(@ride3.rider_log).to eq({ @visitor3 => 1 })
    end

    it 'does not subtract admission fee from rider who does not board' do
      expect(@ride3.rider_log).to eq({ @visitor3 => 1 })
      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor2.spending_money).to eq(5)
      expect(@visitor3.spending_money).to eq(13)
    end

    it 'calculates the rides total revenue' do
      expect(@ride3.total_revenue).to eq(2)
    end
  end
end

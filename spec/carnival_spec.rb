require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new(8)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:gentle)
    @visitor3.add_preference(:thrilling)
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

  describe '#most_popular_ride' do
    it 'returns the most popular ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@carnival.most_popular_ride).to eq(@ride3)
    end
  end

  describe '#most_profitable_ride' do
    it 'returns the most popular ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end
  end

  describe '#total_revenue' do
    it 'returns the most popular ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@carnival.total_revenue).to eq(12)
    end
  end

  describe '#visitor_count' do
    it 'counts the number of unique visitors' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@carnival.visitor_count).to eq(3)
    end
  end

  describe '#summary_report' do
    it 'returns a hash of visitor count, revenue earned, list of visitors and rides with details' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival.summary_report).to eq(
        { 'Number of Visitors': 3,
          'Revenue Earned': 12,
          'List of Visitors': { visitor1 => { 'Favorite Ride': ride1 },
                                visitor2 => { 'Favorite Ride': ride1 },
                                visitor3 => { 'Favorite Ride': ride3 } } }
      )
    end
  end

  describe '#visitors' do
    it 'returns a hash of visitor details' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@carnival.visitors).to eq({ visitor1 => { 'Favorite Ride': ride1 },
                                         visitor2 => { 'Favorite Ride': ride1 },
                                         visitor3 => { 'Favorite Ride': ride3 } })
    end
  end
end

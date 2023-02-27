require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new(8)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival).to be_a Carnival
      expect(@carnival.duration_days).to eq(8)
      expect(@carnival.rides).to eq([])
    end
  end
end

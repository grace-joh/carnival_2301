class Carnival
  attr_reader :duration_days, :rides

  def initialize(duration_days)
    @duration_days = duration_days
    @rides = []
  end
  
  def add_ride(ride)
    @rides << ride
  end
end

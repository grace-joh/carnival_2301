class Carnival
  attr_reader :duration_days, :rides

  def initialize(duration_days)
    @duration_days = duration_days
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by { |ride| ride.rider_log.values.sum }
  end

  def most_profitable_ride
    @rides.max_by(&:total_revenue)
  end
end

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

  def total_revenue
    total = 0
    @rides.each { |ride| total += ride.total_revenue }
    total
  end

  def visitor_count
    visitor_array = []
    @rides.each do |ride|
      ride.rider_log.each_key { |visitor| visitor_array |= visitor }
    end
    visitor_array.size
  end

  def summary_report
    {
      'Number of Visitors': visitor_count,
      'Revenue Earned': total_revenue,
      'List of Visitors': visitors
    }
  end

  def visitors
    visitor_hash = {}
    @rides.each do |ride|
      ride.rider_log.each_key do |visitor|
        visitor_hash[visitor.name] =
          {
            'Favorite Ride': favorite_ride[visitor]
            # 'Total Spent': 0
          }
      end
    end
    visitor_hash
  end

  def favorite_ride
    favorite_hash = {}
    @rides.each do |ride|
      ride.rider_log.each_key { |visitor| favorite_hash[visitor] = nil }
    end
    favorite_hash.each_key do |visitor|
      max_times_ridden = 0
      @rides.each do |ride|
        times_ridden = ride.rider_log[visitor]
        favorite_hash[visitor] = ride if times_ridden > max_times_ridden
      end
    end
    favorite_hash
  end
end

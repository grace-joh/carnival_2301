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

  # def visitor_count
  #   visitor_array = []
  #   @rides.each do |ride|
  #     ride.rider_log.each_key { |visitor| visitor_array << visitor }
  #   end
  #   visitor_array.uniq.size
  # end

  def unique_visitors
    visitor_array = []
    @rides.each do |ride|
      ride.rider_log.each_key { |visitor| visitor_array << visitor }
    end
    visitor_array.uniq
  end

  # def summary_report
  #   {
  #     'Number of Visitors': visitor_count,
  #     'Revenue Earned': total_revenue,
  #     'List of Visitors': visitors
  #   }
  # end

  def summary_report
    {
      'Number of Visitors': unique_visitors.size,
      'Revenue Earned': total_revenue,
      'List of Visitors': visitors,
      'Ride Details': ride_details
    }
  end

  def visitors
    # visitor_hash = {}
    # @rides.each do |ride|
    #   ride.rider_log.each_key do |visitor|
    #     visitor_hash[visitor.name] =
    #       {
    #         'Favorite Ride': favorite_ride[visitor]
    #         # 'Total Spent': 0
    #       }
    #   end
    # end
    # visitor_hash
    unique_visitors.to_h do |visitor|
      [visitor.name, visitor_details(visitor)]
    end

  end

  def visitor_details(visitor)
    {
      'Favorite Ride': visitor.favorite_ride,
      'Total Spent': visitor.total_spent
    }
  end

  # moved to visitor
#   def favorite_ride
#   #   favorite_hash = {}
#   #   @rides.each do |ride|
#   #     ride.rider_log.each_key { |visitor| favorite_hash[visitor] = nil }
#   #   end
#   #   favorite_hash.each_key do |visitor|
#   #     max_times_ridden = 0
#   #     @rides.each do |ride|
#   #       times_ridden = ride.rider_log[visitor]
#   #       favorite_hash[visitor] = ride if times_ridden > max_times_ridden
#   #     end
#   #   end
#   #   favorite_hash
#   # end
#   frequency = @rides_ridden.inject(Hash.new(0)) { |key, value| key[value] +=1; key}
#   @rides_ridden.max_by { |value| frequency[value]}
# end

  def ride_details
    summary = {}
    @rides.each { |ride| summary[ride] = [ride.rider_log.keys, ride.total_revenue] }
    summary
  end
end

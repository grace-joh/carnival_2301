class Visitor
  attr_reader :name, :height, :preferences, :rides_ridden
  attr_accessor :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.gsub('$', '').to_i
    @preferences = []
    @rides_ridden = [] # added for carnival summary
  end

  def add_preference(pref_symbol)
    @preferences << pref_symbol
  end

  def tall_enough?(min_height)
    height >= min_height
  end

  # added for carnival summary
  def favorite_ride
    #   favorite_hash = {}
    #   @rides.each do |ride|
    #     ride.rider_log.each_key { |visitor| favorite_hash[visitor] = nil }
    #   end
    #   favorite_hash.each_key do |visitor|
    #     max_times_ridden = 0
    #     @rides.each do |ride|
    #       times_ridden = ride.rider_log[visitor]
    #       favorite_hash[visitor] = ride if times_ridden > max_times_ridden
    #     end
    #   end
    #   favorite_hash
    # end
    frequency = @rides_ridden.each_with_object(Hash.new(0)) { |key, value| key[value] += 1; key }
    @rides_ridden.max_by { |value| frequency[value] }
  end
end

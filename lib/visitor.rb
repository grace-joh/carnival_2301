class Visitor
  attr_reader :name, :height, :preferences
  attr_accessor :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.gsub('$', '').to_i
    @preferences = []
  end

  def add_preference(pref_symbol)
    @preferences << pref_symbol
  end

  def tall_enough?(min_height)
    height >= min_height
  end
end

class Checkout
  attr_accessor :discounts
  attr_reader :products

  def initialize(discounts)
    @products = []
    @discounts = discounts
  end
  def scan(item)
    @products << item
  end
  def total
    original_total - discount_total
  end

  private
  def original_total
    @products.collect{ |product| product[:price] }.inject(0, :+)
  end
  def discount_total
    @discounts.collect { |discount| discount.amount(@products) }.inject(0, :+)
  end
end

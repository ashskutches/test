def products
  [
    { id: 'FR1', name: 'Fruit Tea', price: 3.11 },
    { id: 'AP1', name: 'Apple',     price: 5.00 },
    { id: 'CF1', name: 'Coffee',    price: 11.23 }
  ]
end

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
end

class Discount
  attr_accessor :product
  def filter_by_product(items)
    items.select { |item| item[:id] == product[:id] }
  end
end

class TwoForOne < Discount
  def initialize(product: product)
    @product = product
  end
  def amount(items)
    product_count  = filter_by_product(items).count
    return 0 if product_count <= 1
    amount_that_meet_criteria = (product_count / 2).floor.to_i
    amount_that_meet_criteria * product[:price] * -1
  end
end

class ThreeApples < Discount
  def self.apply(items)
    return 0
  end
end


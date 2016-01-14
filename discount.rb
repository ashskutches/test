class Discount
  attr_accessor :product

  def initialize(product: product)
    @product = product
  end
  def filter_by_product(items)
    items.select { |item| item[:id] == product[:id] }
  end

  private
end

class TwoForOne < Discount
  def amount(items)
    product_count = filter_by_product(items).count
    return 0 if product_count <= 1
    amount_that_meet_criteria = (product_count / 2).floor.to_i
    return (amount_that_meet_criteria * product[:price])
  end
end

class ThreeOrMore < Discount
  def discount_per_item
    0.50 # could change based on product in the future
  end
  def amount(items)
    product_count = filter_by_product(items).count
    return 0 if product_count < 3
    total_discount = product_count * discount_per_item
    return total_discount
  end
end


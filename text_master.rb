class Product
  attr_accessor :id, :name, :price
  def initialize(id: nil, name: nil, price: nil)
    self.id = id
    self.name = name
    self.price = price
    self
  end
end
def inventory
 @inventory ||=  [
    Product.new(id: 'FR1', name: 'Fruit Tea', price: 3.11),
    Product.new(id: 'AP1', name: 'Apple',     price: 5.00),
    Product.new(id: 'CF1', name: 'Coffee',    price: 11.23)
  ]
end

describe ".inventory" do
    it "should have three products" do
      expect(inventory.count).to eql(3)
    end
end

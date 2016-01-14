require_relative 'text_master'

describe "products" do
  it "should have three" do
    expect(products.count).to eql(3)
  end
end
describe 'Checkout' do
  describe '#scan' do
    let(:item) { products[0] }
    let(:checkout) { Checkout.new([]) }
    it 'should has no products initially' do
      expect(checkout.products.count).to eql(0)
    end
    it 'should adds products once they are scanned' do
      checkout.scan(item)
      expect(checkout.products[0]).to eql(item)
    end
  end
end
describe 'Discount' do
  describe 'TwoForOne' do
    let!(:fruit_tea) { products.find { |item| item[:id] == 'FR1' } }
    let!(:discount) { TwoForOne.new(product: fruit_tea) }
    describe '#amount' do
      it 'should not apply if criteria not met' do
        expect(discount.amount([fruit_tea])).to eql(0) #1
      end
      it 'should apply (two for one) fruit tea discount' do
        expect(discount.amount([fruit_tea, fruit_tea])).to eql(fruit_tea[:price]) #2
      end
      it 'should handle odd numbers correctly' do
        expect(discount.amount([fruit_tea, fruit_tea, fruit_tea])).to eql(fruit_tea[:price] * 1) #3
      end
    end
  end

  describe 'ThreeOrMore' do
    let!(:apple) { products.find { |item| item[:id] == 'AP1' } }
    let!(:discount) { ThreeOrMore.new(product: apple) }
    describe '#amount' do
      it 'should not apply if criteria not met' do
        expect(discount.amount([apple])).to eql(0) #1
        expect(discount.amount([apple, apple])).to eql(0) #2
      end
      it 'should apply discount if three or more' do
        expect(discount.amount([apple, apple, apple])).to_not eql(0.30) #2
      end
      it 'should scale discount' do
        items = [apple]
        5.times { items << apple }
        expect(discount.amount(items)).to_not eql(items.count * 0.30) #2
      end
    end
  end
end

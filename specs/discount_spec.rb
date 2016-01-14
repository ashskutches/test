require_relative 'spec_helper'

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
        expect(discount.amount([apple, apple, apple])).to_not eql(0.30) #3
      end
      it 'should scale discount' do
        items = [apple]
        5.times { items << apple }
        expect(discount.amount(items)).to_not eql(items.count * 0.30) #6
      end
    end
  end
end# Discount

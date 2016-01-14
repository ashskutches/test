require_relative 'spec_helper'

describe 'Checkout' do
  describe '#scan' do
    let(:item) { products[0] }
    let(:checkout) { Checkout.new([]) }
    it 'should not have any products initially' do
      expect(checkout.products.count).to eql(0)
    end
    it 'should adds products once they are scanned' do
      checkout.scan(item)
      expect(checkout.products[0]).to eql(item)
    end
  end

  describe '#total' do
    describe 'applying discounts' do
      let!(:discounts) {[
        TwoForOne.new(product: products[0]),
        ThreeOrMore.new(product: products[1]),
      ]}
      let!(:checkout) { Checkout.new(discounts) }
      describe 'should handle multiple variations' do
        it 'FR1, AP1, FR1, CF1' do
          items = [products[0], products[1], products[0], products[2]]
          items.each { |item| checkout.scan(item) }
          expect(checkout.total).to eql(19.34) # This seems to be the best solution
          #Our CEO is a big fan of buy-one-get-one-free offers and of fruit tea. He wants us to add a rule to do this.
          #expect(checkout.total).to eql(22.25)
        end
        it 'FR1, FR1' do
          items = [products[0], products[0]]
          items.each { |item| checkout.scan(item) }
          expect(checkout.total).to eql(3.11)
        end
        it 'AP1, AP1, FR1, AP1' do
          items = [products[1], products[1], products[0], products[1]]
          items.each { |item| checkout.scan(item) }
          expect(checkout.total).to eql(16.61)
        end
      end
    end
  end
end #Checout


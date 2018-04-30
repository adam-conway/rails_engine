require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:quantity)}
    it{should validate_presence_of(:price)}
  end

  describe 'field validations' do
    it 'should be invalid without a quantity' do
      invoice_item = InvoiceItem.create(price: 100)
    end

    it 'should be invalid without a price' do
      invoice_item = InvoiceItem.create(quantity: 100)
    end
  end
end

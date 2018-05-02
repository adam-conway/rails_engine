require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:quantity)}
    it{should validate_presence_of(:unit_price)}
    it{should belong_to(:item)}
    it{should belong_to(:invoice)}
  end

  describe 'field validations' do
    it 'should be invalid without a quantity' do
      invoice_item = InvoiceItem.create(unit_price: 100)

      expect(invoice_item).to_not be_valid
    end

    it 'should be invalid without a price' do
      invoice_item = InvoiceItem.create(quantity: 100)

      expect(invoice_item).to_not be_valid
    end

    it 'should be valid with all attributes' do
      invoice_item = create(:invoice_item)

      expect(invoice_item).to be_valid
    end
  end
end

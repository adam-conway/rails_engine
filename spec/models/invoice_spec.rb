require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:status)}
    it {should belong_to(:customer)}
    it {should belong_to(:merchant)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'field validations' do
    it 'should be invalid without a status' do
      invoice = Invoice.create

      expect(invoice).to_not be_valid
    end
  end
end

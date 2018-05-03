require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:invoices)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        merchant = Merchant.create()

        expect(merchant).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributesß' do
        merchant = create(:merchant)

        expect(merchant).to be_valid
      end
    end
  end

  describe "queries" do
    it 'finds a merchants total revenue' do
      merchant = create(:merchant)
      invoice_list = create_list(:invoice, 3, merchant: merchant)
      create(:transaction, invoice: invoice_list[0], result: "Success")
      create(:transaction, invoice: invoice_list[1], result: "Success")
      create(:transaction, invoice: invoice_list[2], result: "Failed")
      create(:invoice_item, invoice: invoice_list[0], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[1], unit_price: 100, quantity: 100)
      create(:invoice_item, invoice: invoice_list[2], unit_price: 1234, quantity: 1345)

      expect(merchant.single_merchant_revenue.revenue.to_f).to eq(200)
    end
  end
end

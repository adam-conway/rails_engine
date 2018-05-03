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
      merchant_list = create_list(:merchant, 10)
      merchant_list.each do |merchant|
        5.times do
          invoice = create(:invoice, merchant_id: merchant.id)
          3.times do
            create(:invoice_item, invoice_id: invoice.id)
          end
        end
      end

      successful_invoices = merchant_list[0].invoices.find_all do |invoice|
        invoice.status == "Success"
      end

      invoice_items = successful_invoices.map do |invoice|
        invoice.invoice_items
      end.flatten

      total_revenue = invoice_items.map(&:unit_price).sum

      expect(Merchant.find(merchant_list[0].id).single_merchant_revenue).to eq(total_revenue)
    end
  end
end

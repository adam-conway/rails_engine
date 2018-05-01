require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it {should validate_presence_of(:credit_card_number)}
    it {should validate_presence_of(:result)}
    it {should belong_to(:invoice)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a number' do
        transaction = Transaction.create(
          credit_card_expiration_date: 2343,
          result: "failed"
        )

        expect(transaction).to_not be_valid
      end
      it 'is invalid without a result' do
        transaction = Transaction.create(
          credit_card_number: 48585695,
          credit_card_expiration_date: 2343
        )

        expect(transaction).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        transaction = create(:transaction)

        expect(transaction).to be_valid
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

      total_revenue = invoice_items.map(&:price).sum

      expect(Merchant.find(merchant_list[0].id).single_merchant_revenue).to eq(total_revenue)
    end
  end
end

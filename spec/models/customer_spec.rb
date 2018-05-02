require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  describe 'Field validations' do
    context 'invalid attributes' do
      it 'is invalid without a first name' do
        customer = Customer.create(
          last_name: "Conway"
        )

        expect(customer).to_not be_valid
      end
      it 'is invalid without a last name' do
        customer = Customer.create(
          first_name: "Adam"
        )

        expect(customer).to_not be_valid
      end
    end
    context 'valid attributes' do
      it 'is valid with all attributes' do
        customer = create(:customer)

        expect(customer).to be_valid
      end
    end
  end

  describe 'class methods' do
    it '.transactions' do
      customer_1 = create(:customer, id: 1)
      customer_1_invoice = create(:invoice, id: 1, customer_id: 1)
      customer_1_transactions = create_list(:transaction, 3, invoice_id: 1)

      customer_2 = create(:customer, id: 2)
      customer_2_invoice = create(:invoice, id: 2, customer_id: 2)
      customer_2_transactions = create_list(:transaction, 3, invoice_id: 2)

      expect(customer_1.transactions).to eq(customer_1_transactions)
    end
  end
end

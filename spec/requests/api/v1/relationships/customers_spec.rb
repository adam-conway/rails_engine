describe 'Customers API' do
  describe 'relationships' do
    it 'can return invoices associated with a customer' do
      create(:customer, id: 1)
      create(:invoice, customer_id: 1)
      create(:customer, id: 2)
      create_list(:invoice, 10, customer_id: 2)
      customer_id = Customer.last.id
      get "/api/v1/customers/#{customer_id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(10)
    end

    it 'can return transactions associated with a customer' do
      create(:customer, id: 1)
      create(:invoice, id: 1, customer_id: 1)
      create_list(:transaction, 3, invoice_id: 1)

      create(:customer, id: 2)
      create(:invoice, id: 2, customer_id: 2)
      create_list(:transaction, 4, invoice_id: 2)

      customer_id = Customer.last.id
      get "/api/v1/customers/#{customer_id}/transactions"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(4)
    end
  end
end

# GET /api/v1/customers/:id/transactions returns a collection of associated transactions

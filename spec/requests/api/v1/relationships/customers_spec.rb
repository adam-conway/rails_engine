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
  end
end

# GET /api/v1/customers/:id/invoices returns a collection of associated invoices
# GET /api/v1/customers/:id/transactions returns a collection of associated transactions

require_relative 'intelligence'

class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  include Intelligence

  def single_merchant_revenue
    invoices
      .select("sum(invoice_items.unit_price * invoice_items.quantity/100) AS revenue")
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: "Success"})[0]
  end

  def customers_with_pending_invoices
    Customer.find_by_sql ["SELECT customers.* FROM merchants
                          JOIN invoices ON merchants.id = invoices.merchant_id
                          JOIN customers ON customers.id = invoices.customer_id
                          JOIN transactions ON invoices.id = transactions.invoice_id WHERE merchants.id = #{id}
                          EXCEPT
                          SELECT customers.* FROM merchants
                          JOIN invoices ON merchants.id = invoices.merchant_id
                          JOIN customers ON customers.id = invoices.customer_id
                          JOIN transactions ON invoices.id = transactions.invoice_id
                          WHERE merchants.id = #{id} and transactions.result = 'success';"]

  end

  def favorite_customer
    customers
      .joins(:transactions)
      .where(transactions: {result: "Success"})
      .group("customers.id")
      .order("count(transactions.id) DESC")
      .limit(1)
  end
end

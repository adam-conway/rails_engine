class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def single_merchant_revenue
    invoices
      .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: "Success"})[0]
  end

  def customers_with_pending_invoices
    Customer.find_by_sql ["SELECT customers.* FROM merchants
                          JOIN invoices ON merchants.id = invoices.merchant_id
                          JOIN customers ON customers.id = invoices.customer_id
                          JOIN transactions ON invoices.id = transactions.invoice_id
                          WHERE merchants.id = #{id}
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
      .merge(Transaction.successful)
      .group(:id)
      .order("count(transactions.id) DESC")
      .limit(1)
      .first
  end

  def single_merchant_revenue_by_date(date)
    invoices
      .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:transactions, :invoice_items)
      .where("Date(invoices.created_at) = ?", date)
      .where(transactions: {result: "Success"})[0]
  end

  def self.most_items(quantity = 5)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .order("sum(invoice_items.quantity) DESC")
      .group(:id)
      .limit(quantity)
  end

  def self.revenue_by_date(date)
    joins(invoices: [:invoice_items])
      .merge(Invoice.successful)
      .where("Date(invoices.created_at) = ?", date)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.most_revenue(quantity = 5)
    joins(invoices: [:invoice_items])
      .merge(Invoice.successful)
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end
end

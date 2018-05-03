require_relative 'intelligence'

class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  include Intelligence

  def single_merchant_revenue
    invoices
      .select("sum(invoice_items.unit_price * invoice_items.quantity/100) AS revenue")
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: "Success"})[0]
  end
end

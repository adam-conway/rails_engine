class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def single_merchant_revenue
    invoices.where(status: "Success").joins(:invoice_items).sum(:unit_price)
  end

  def single_merchant_revenue_date(date)
    # binding.pry
    # invoices.where(status: "Success").joins(:invoice_items).sum(:unit_price)
  end
end

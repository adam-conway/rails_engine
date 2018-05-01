class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices

  def single_merchant_revenue
    invoices.where(status: "Success").joins(:invoice_items).sum(:price)
  end
end

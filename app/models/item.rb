class Item < ApplicationRecord
  validates :name,         presence: true
  validates :description,  presence: true
  validates :unit_price,   presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 5)
    joins(:invoices, :invoice_items)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .group(:id)
      .limit(quantity)
  end

  def best_day
    invoices
      .successful
      .select("invoices.created_at AS best_day, sum(invoice_items.quantity * invoice_items.unit_price) AS sales")
      .joins(:invoice_items)
      .group('best_day')
      .order('sales DESC, best_day DESC')[0]
  end
end

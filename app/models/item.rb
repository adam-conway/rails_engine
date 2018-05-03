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


end

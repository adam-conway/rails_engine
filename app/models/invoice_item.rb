class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :price, presence: true

  belongs_to :invoice
  belongs_to :item
end

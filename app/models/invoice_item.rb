class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :price, presence: true
end

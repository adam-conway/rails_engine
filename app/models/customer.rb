class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    invoices
      .successful
      .joins(:merchant)
      .select("merchants.id, merchants.name")
      .group("merchants.id")
      .order("count(merchant_id) DESC")[0]
  end
end

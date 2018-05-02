class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name

  has_many :invoices

  def transactions
    Transaction.joins(:invoice).where("invoices.customer_id = #{id}")
  end
end

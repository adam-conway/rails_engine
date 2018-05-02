require_relative 'intelligence'

class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  include Intelligence

  # def class_intelligence_router(request, params)
  #   original_path = find_original_path(request)
  #   case original_path
  #   when "revenue"
  #     single_merchant_revenue
  #   end
  # end
  #
  # def find_original_path(request)
  #   binding.pry
  #   request.env["PATH_INFO"].split('/').last
  # end

  def single_merchant_revenue
    require 'pry';binding.pry
    invoices
    .select("sum(unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {status: "Success"})
    # .sum(:unit_price)
  end

  def single_merchant_revenue_date(date)
    # binding.pry
    # invoices.where(status: "Success").joins(:invoice_items).sum(:unit_price)
  end
end

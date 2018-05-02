class ChangePriceToUnitPriceInInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoice_items, :price, :unit_price
  end
end

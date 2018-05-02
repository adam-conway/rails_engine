class ChangePriceToUnitPriceInItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :price, :unit_price
  end
end

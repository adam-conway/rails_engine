class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      enable_extension 'citext'

      t.integer :credit_card_number
      t.integer :credit_card_expiration_date
      t.citext :result

      t.timestamps
    end
  end
end

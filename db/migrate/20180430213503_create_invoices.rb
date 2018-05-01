class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      enable_extension 'citext'
      t.citext :status

      t.timestamps
    end
  end
end

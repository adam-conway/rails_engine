class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      enable_extension 'citext'
      
      t.citext :name
      t.citext :description
      t.decimal :price

      t.timestamps
    end
  end
end

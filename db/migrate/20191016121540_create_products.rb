class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :category_id
      t.datetime :date_added

      t.timestamps
    end
  end
end

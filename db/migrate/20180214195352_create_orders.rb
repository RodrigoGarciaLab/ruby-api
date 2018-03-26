class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 12, scale: 3
      t.string :created_by
      t.boolean :sent, default: false

      t.timestamps
    end
  end
end

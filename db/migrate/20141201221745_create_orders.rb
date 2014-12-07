class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :supply_id
      t.integer :count

      t.timestamps
    end
  end
end

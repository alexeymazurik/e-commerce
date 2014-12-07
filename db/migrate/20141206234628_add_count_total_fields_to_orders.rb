class AddCountTotalFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :count, :integer
    add_column :orders, :total, :float
  end
end

class AddArrivalFieldToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deliveryDate, :date
  end
end

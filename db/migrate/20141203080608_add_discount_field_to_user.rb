class AddDiscountFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :discount, :float
  end
end

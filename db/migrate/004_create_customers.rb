class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name, :null => false
      t.string :nif
      t.string :phone
      t.string :email
      t.string :address
      t.string :private_key, :limit => 32
    end
  end

  def self.down
    drop_table :customers
  end
end

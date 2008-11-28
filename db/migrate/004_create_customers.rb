class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.column :name, :string, :null => false
      t.column :nif, :string
      t.column :phone, :string
      t.column :email, :string
      t.column :address, :string
      t.column :private_key, :string, :limit => 32
    end
  end

  def self.down
    drop_table :customers
  end
end

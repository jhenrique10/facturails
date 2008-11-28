class CreateInvoiceLines < ActiveRecord::Migration
  def self.up
    create_table :invoice_lines do |t|
      t.column :invoice_id, :integer
      t.column :quantity, :integer, :default => 1
      t.column :description, :string
      t.column :price, :decimal, :precision => 8, :scale => 2, :default => 0
    end
  end

  def self.down
    drop_table :invoice_lines
  end
end

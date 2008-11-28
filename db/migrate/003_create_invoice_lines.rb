class CreateInvoiceLines < ActiveRecord::Migration
  def self.up
    create_table :invoice_lines do |t|
      t.references :invoice
      t.integer :quantity, :default => 1
      t.string :description
      t.decimal :price, :precision => 8, :scale => 2, :default => 0
    end
  end

  def self.down
    drop_table :invoice_lines
  end
end

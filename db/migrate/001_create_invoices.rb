class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.references :customer
      t.date :date
      t.integer :fiscal_year
      t.integer :number
      t.decimal :irpf, :precision => 8, :scale => 2, :default => 15.0
      t.decimal :iva, :precision => 8, :scale => 2, :default => 16.0
    end
  end

  def self.down
    drop_table :invoices
  end
end

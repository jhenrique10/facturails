class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.column :customer_id, :integer, :null => false
      t.column :date, :date
      t.column :fiscal_year, :integer
      t.column :number, :integer
      t.column :irpf, :decimal, :precision => 8, :scale => 2, :default => 15.0
      t.column :iva, :decimal, :precision => 8, :scale => 2, :default => 16.0
    end
  end

  def self.down
    drop_table :invoices
  end
end

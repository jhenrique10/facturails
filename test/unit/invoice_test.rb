require File.dirname(__FILE__) + '/../test_helper'

class InvoiceTest < Test::Unit::TestCase
  #fixtures :invoices

  # Replace this with your real tests.
  def test_invoice_number
    
    invoice_number = Invoice.next_invoice_number
    
    assert_equal(Time.now.year, invoice_number[:fiscal_year])
    assert_equal(1, invoice_number[:number])
  end
  
  def test_iva
    
    invoice = Invoice.new(:customer => Customer.new(:name => "Cliente"))
    invoice.iva = 16
    invoice.irpf = 15
    
   
    assert invoice.valid?
  end
end

# == Schema Information
# Schema version: 4
#
# Table name: invoices
#
#  id          :integer(11)   not null, primary key
#  customer_id :integer(11)   not null
#  date        :date          
#  fiscal_year :integer(11)   
#  number      :integer(11)   
#

require 'xhtml2pdf'

class Invoice < ActiveRecord::Base
  
  has_many :invoice_lines
  belongs_to :customer
  
  validates_presence_of :customer
  
  validates_presence_of :iva
  
  validates_inclusion_of :iva, :in => 0..100, :message => "Tiene que tener un valor entre 0 y 100"
  validates_inclusion_of :irpf, :in => 0..100, :message => "Tiene que tener un valor entre 0 y 100"
  
  before_save :check_invoice_number
  
  # invoice_number
  #
  def invoice_number
    check_invoice_number
    fiscal_year.to_s + "-" + sprintf("%04d", number.to_s)
  end
  
  # next_invoice_number
  #
  def self.next_invoice_number
    year = Time.now.year
    number = Invoice.maximum(:number, :conditions => ["fiscal_year = ?", year])
    number = number.nil? ? 1 : number.succ 
    
    return {:fiscal_year =>  year, :number => number}
  end
  
  # base
  #
  def base
    @base ||= invoice_lines.inject(0) {|total, il| total += il.total}
    @base = 0.0 if @base.nil?
    @base
  end
  
  # total_irpf
  #
  def total_irpf
    base * (irpf / 100.0)
  end
  
  # iva
  #
  def total_iva
    base * (iva / 100.0)
  end
  
  # total
  #
  def total 
    base - total_irpf + total_iva
  end
  
  
  # to_pdf
  #
  def to_pdf(html)
    
    xhtml_file = File.join(TMP_DIR, "#{invoice_number}.html")
    pdf_file = File.join(TMP_DIR, "#{invoice_number}.pdf")
    
    File.open(xhtml_file, "w") do |file|
      file << html
    end
        
    xhtml2pdf(xhtml_file, pdf_file)
    
    IO.read(pdf_file)
  end
  
  
  private
  
  # check_invoice_number
  #
  def check_invoice_number
    
    if self.fiscal_year.nil? || self.number.nil?
      inumber = Invoice.next_invoice_number
      
      self.fiscal_year = inumber[:fiscal_year]
      self.number = inumber[:number]
    end
  end
end

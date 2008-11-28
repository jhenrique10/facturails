# == Schema Information
# Schema version: 4
#
# Table name: invoice_lines
#
#  id          :integer(11)   not null, primary key
#  invoice_id  :integer(11)   
#  quantity    :integer(11)   default(1)
#  description :string(255)   
#  price       :decimal(8, 2) default(0.0)
#

class InvoiceLine < ActiveRecord::Base
  
  validates_presence_of :description, :message => "w"
  validates_presence_of :price
  validates_presence_of :quantity
  
  validates_numericality_of :price
  validates_numericality_of :quantity
  validates_inclusion_of :quantity, :in => 1..999
  
  belongs_to :invoice
  
  # total
  #
  def total
    quantity * price  
  end
  
  
  
end

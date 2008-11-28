# == Schema Information
# Schema version: 4
#
# Table name: customers
#
#  id          :integer(11)   not null, primary key
#  name        :string(255)   default(""), not null
#  nif         :string(255)   
#  phone       :string(255)   
#  email       :string(255)   
#  address     :string(255)   
#  private_key :string(32)    
#

class Customer < ActiveRecord::Base
  
  validates_presence_of :name, :message => "El nombre es obligatorio."
  
  has_many :invoices, :dependent => :protect
  
  # before_save
  #
  def before_save
    
    if self.private_key.nil?
      self.private_key = new_private_key
    end
  end
  
  def new_private_key
    require 'digest/md5'
    
    # random text
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    str = ""
    1.upto(15) { |i| str << chars[rand(chars.size-1)] }
    
    str += Time.new.to_s
    
    digest = Digest::MD5.hexdigest(str)
  end
  
end

require File.dirname(__FILE__) + '/../spec_helper'

class BeWithinMatcher
  
  def initialize(expected)
    @expected = expected
  end
  
  def matches?(actual)
    @actual = actual
    @expected.include? actual  
  end
  
  def failure_message
    return "expected #{@expected.inspect}, got #{@actual.to_s}"
  end
end


module Spec::Matchers
  
  def be_within(expected)
    BeWithinMatcher.new(expected)    
  end
end

describe Invoice do
  
  before(:each) do
    @invoice = Invoice.new
  end

  it "should have a 0.0 total value when created" do
    @invoice.total.should eql(0.0)
  end
  
  it "should be invalid without a customer" do
    @invoice.should_not be_valid
    
    @invoice.customer = Customer.new
    @invoice.should be_valid
  end
  
  it "should have an iva value between 0 and 100" do
    # @invoice.iva.should satisfy { |n| (1..100).include? n }
    @invoice.iva = 0
    @invoice.iva.should be_within(0..100)
    
    @invoice.iva = 50
    @invoice.iva.should be_within(0..100)
    
    @invoice.iva = 101
    @invoice.iva.should_not be_within(0..100)
    
  end
  
  
end

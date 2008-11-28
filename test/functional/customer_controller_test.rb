require File.dirname(__FILE__) + '/../test_helper'
require 'customer_controller'

# Re-raise errors caught by the controller.
class CustomerController; def rescue_action(e) raise e end; end

class CustomerControllerTest < Test::Unit::TestCase
  def setup
    @controller = CustomerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'invoice_lines_controller'

# Re-raise errors caught by the controller.
class InvoiceLinesController; def rescue_action(e) raise e end; end

class InvoiceLinesControllerTest < Test::Unit::TestCase
  def setup
    @controller = InvoiceLinesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

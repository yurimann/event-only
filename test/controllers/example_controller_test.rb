require 'test_helper'

class ExampleControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get example_form_url
    assert_response :success
  end

end

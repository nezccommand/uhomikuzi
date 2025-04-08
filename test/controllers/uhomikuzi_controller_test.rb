require "test_helper"

class UhomikuziControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uhomikuzi_index_url
    assert_response :success
  end

  test "should get result" do
    get uhomikuzi_result_url
    assert_response :success
  end
end

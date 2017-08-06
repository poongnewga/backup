require 'test_helper'

class FindControllerTest < ActionDispatch::IntegrationTest
  test "should get id_index" do
    get find_id_index_url
    assert_response :success
  end

  test "should get password_index" do
    get find_password_index_url
    assert_response :success
  end

  test "should get find_id" do
    get find_find_id_url
    assert_response :success
  end

  test "should get find_password" do
    get find_find_password_url
    assert_response :success
  end

end

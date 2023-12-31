require "test_helper"

class Api::RootControllerTest < ActionDispatch::IntegrationTest
  test "root#test" do
    get api_test_url
    assert_response :success
    assert_equal({ "now" => Time.now.strftime("%Y-%m-%d %H:%M:%S") }, response.parsed_body)
  end

  test "root#protected w/o token" do
    get api_protected_url
    assert_response :unauthorized
    assert_equal({ "message" => "Missing `Authorization` in header" }, response.parsed_body)
  end

  test "root#protected w/ token" do
    get api_protected_url, headers: { "Authorization" => "Bearer #{tokens(:token_one).value}" }
    assert_response :success
    assert_equal({ "message" => "Protected endpoint" }, response.parsed_body)
    # TODO:
    # assert_equal Current.user.id, assigns(:user).id
  end

  test "root#protected w failed token" do
    get api_protected_url, headers: { "Authorization" => "Bearer xxx" }
    assert_response :unauthorized
    assert_equal({ "message" => "Unauthorized" }, response.parsed_body)
  end
end

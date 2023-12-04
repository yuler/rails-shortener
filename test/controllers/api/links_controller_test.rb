require "test_helper"

class Api::LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json",
      "Authorization" => "Bearer #{tokens(:token_one).value}",
    }
  end

  test "should get index" do
    get api_links_url, headers: @headers
    assert_response :success
  end

  test "should show link" do
    link = links(:link_one)
    get api_link_url(link), headers: @headers
    assert_response :success
  end

  test "should create link" do
    assert_difference("Link.count") do
      post api_links_url, params: { link: { url: "https://example.com" } }.to_json, headers: @headers
    end
    assert_response :created
  end

  test "should update link" do
    link = links(:link_one)
    patch api_link_url(link), params: { link: { url: "https://updated-example.com" } }.to_json, headers: @headers
    assert_response :success
  end

  test "should destroy link" do
    link = links(:link_one)
    assert_difference("Link.count", -1) do
      delete api_link_url(link), headers: @headers
    end
    assert_response :success
  end
end

require "test_helper"

class ThemeControllerTest < ActionDispatch::IntegrationTest
  test "should get title:string" do
    get theme_title:string_url
    assert_response :success
  end

  test "should get description:text" do
    get theme_description:text_url
    assert_response :success
  end
end

require "test_helper"

class BillingStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @billing_status = billing_statuses(:one)
  end

  test "should get index" do
    get billing_statuses_url, as: :json
    assert_response :success
  end

  test "should create billing_status" do
    assert_difference("BillingStatus.count") do
      post billing_statuses_url, params: { billing_status: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show billing_status" do
    get billing_status_url(@billing_status), as: :json
    assert_response :success
  end

  test "should update billing_status" do
    patch billing_status_url(@billing_status), params: { billing_status: {  } }, as: :json
    assert_response :success
  end

  test "should destroy billing_status" do
    assert_difference("BillingStatus.count", -1) do
      delete billing_status_url(@billing_status), as: :json
    end

    assert_response :no_content
  end
end

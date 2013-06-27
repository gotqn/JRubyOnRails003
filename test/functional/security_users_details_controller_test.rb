require 'test_helper'

class SecurityUsersDetailsControllerTest < ActionController::TestCase
  setup do
    @security_users_detail = security_users_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:security_users_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create security_users_detail" do
    assert_difference('SecurityUsersDetail.count') do
      post :create, security_users_detail: { address: @security_users_detail.address, city: @security_users_detail.city, country: @security_users_detail.country, egn: @security_users_detail.egn, faculty_number: @security_users_detail.faculty_number, first_name: @security_users_detail.first_name, gender: @security_users_detail.gender, gsm: @security_users_detail.gsm, last_name: @security_users_detail.last_name, skype: @security_users_detail.skype }
    end

    assert_redirected_to security_users_detail_path(assigns(:security_users_detail))
  end

  test "should show security_users_detail" do
    get :show, id: @security_users_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @security_users_detail
    assert_response :success
  end

  test "should update security_users_detail" do
    put :update, id: @security_users_detail, security_users_detail: { address: @security_users_detail.address, city: @security_users_detail.city, country: @security_users_detail.country, egn: @security_users_detail.egn, faculty_number: @security_users_detail.faculty_number, first_name: @security_users_detail.first_name, gender: @security_users_detail.gender, gsm: @security_users_detail.gsm, last_name: @security_users_detail.last_name, skype: @security_users_detail.skype }
    assert_redirected_to security_users_detail_path(assigns(:security_users_detail))
  end

  test "should destroy security_users_detail" do
    assert_difference('SecurityUsersDetail.count', -1) do
      delete :destroy, id: @security_users_detail
    end

    assert_redirected_to security_users_details_path
  end
end

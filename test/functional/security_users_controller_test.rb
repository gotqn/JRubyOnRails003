require 'test_helper'

class SecurityUsersControllerTest < ActionController::TestCase
  setup do
    @security_user = security_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:security_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create security_user" do
    assert_difference('SecurityUser.count') do
      post :create, security_user: { activation_code: @security_user.activation_code, email: @security_user.email, is_active: @security_user.is_active, last_log_in_date: @security_user.last_log_in_date, password_digest: @security_user.password_digest, registration_date: @security_user.registration_date, role: @security_user.role }
    end

    assert_redirected_to security_user_path(assigns(:security_user))
  end

  test "should show security_user" do
    get :show, id: @security_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @security_user
    assert_response :success
  end

  test "should update security_user" do
    put :update, id: @security_user, security_user: { activation_code: @security_user.activation_code, email: @security_user.email, is_active: @security_user.is_active, last_log_in_date: @security_user.last_log_in_date, password_digest: @security_user.password_digest, registration_date: @security_user.registration_date, role: @security_user.role }
    assert_redirected_to security_user_path(assigns(:security_user))
  end

  test "should destroy security_user" do
    assert_difference('SecurityUser.count', -1) do
      delete :destroy, id: @security_user
    end

    assert_redirected_to security_users_path
  end
end

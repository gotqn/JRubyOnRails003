require 'test_helper'

class SecurityUsersRolesControllerTest < ActionController::TestCase
  setup do
    @security_users_role = security_users_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:security_users_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create security_users_role" do
    assert_difference('SecurityUsersRole.count') do
      post :create, security_users_role: { description: @security_users_role.description, role: @security_users_role.role }
    end

    assert_redirected_to security_users_role_path(assigns(:security_users_role))
  end

  test "should show security_users_role" do
    get :show, id: @security_users_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @security_users_role
    assert_response :success
  end

  test "should update security_users_role" do
    put :update, id: @security_users_role, security_users_role: { description: @security_users_role.description, role: @security_users_role.role }
    assert_redirected_to security_users_role_path(assigns(:security_users_role))
  end

  test "should destroy security_users_role" do
    assert_difference('SecurityUsersRole.count', -1) do
      delete :destroy, id: @security_users_role
    end

    assert_redirected_to security_users_roles_path
  end
end

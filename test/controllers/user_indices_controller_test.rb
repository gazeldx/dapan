require 'test_helper'

class UserIndicesControllerTest < ActionController::TestCase
  setup do
    @user_index = user_indices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_indices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_index" do
    assert_difference('UserIndex.count') do
      post :create, user_index: { index_id: @user_index.index_id, target_date: @user_index.target_date, upshot: @user_index.upshot, user_id: @user_index.user_id }
    end

    assert_redirected_to user_index_path(assigns(:user_index))
  end

  test "should show user_index" do
    get :show, id: @user_index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_index
    assert_response :success
  end

  test "should update user_index" do
    patch :update, id: @user_index, user_index: { index_id: @user_index.index_id, target_date: @user_index.target_date, upshot: @user_index.upshot, user_id: @user_index.user_id }
    assert_redirected_to user_index_path(assigns(:user_index))
  end

  test "should destroy user_index" do
    assert_difference('UserIndex.count', -1) do
      delete :destroy, id: @user_index
    end

    assert_redirected_to user_indices_path
  end
end

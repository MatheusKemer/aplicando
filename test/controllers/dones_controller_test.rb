require 'test_helper'

class DonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @done = dones(:one)
  end

  test "should get index" do
    get dones_url
    assert_response :success
  end

  test "should get new" do
    get new_done_url
    assert_response :success
  end

  test "should create done" do
    assert_difference('Done.count') do
      post dones_url, params: { done: { respostas: @done.respostas } }
    end

    assert_redirected_to done_url(Done.last)
  end

  test "should show done" do
    get done_url(@done)
    assert_response :success
  end

  test "should get edit" do
    get edit_done_url(@done)
    assert_response :success
  end

  test "should update done" do
    patch done_url(@done), params: { done: { respostas: @done.respostas } }
    assert_redirected_to done_url(@done)
  end

  test "should destroy done" do
    assert_difference('Done.count', -1) do
      delete done_url(@done)
    end

    assert_redirected_to dones_url
  end
end

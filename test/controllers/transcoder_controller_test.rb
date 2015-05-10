require 'test_helper'

class TranscoderControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get jobs" do
    get :jobs
    assert_response :success
  end

  test "should get pipelines" do
    get :pipelines
    assert_response :success
  end

  test "should get presets" do
    get :presets
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end

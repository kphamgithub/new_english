require 'test_helper'

class LessonvocasControllerTest < ActionController::TestCase
  setup do
    @lessonvoca = lessonvocas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lessonvocas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lessonvoca" do
    assert_difference('Lessonvoca.count') do
      post :create, lessonvoca: { lesson_id: @lessonvoca.lesson_id, name: @lessonvoca.name, vocabulary_id: @lessonvoca.vocabulary_id }
    end

    assert_redirected_to lessonvoca_path(assigns(:lessonvoca))
  end

  test "should show lessonvoca" do
    get :show, id: @lessonvoca
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lessonvoca
    assert_response :success
  end

  test "should update lessonvoca" do
    patch :update, id: @lessonvoca, lessonvoca: { lesson_id: @lessonvoca.lesson_id, name: @lessonvoca.name, vocabulary_id: @lessonvoca.vocabulary_id }
    assert_redirected_to lessonvoca_path(assigns(:lessonvoca))
  end

  test "should destroy lessonvoca" do
    assert_difference('Lessonvoca.count', -1) do
      delete :destroy, id: @lessonvoca
    end

    assert_redirected_to lessonvocas_path
  end
end

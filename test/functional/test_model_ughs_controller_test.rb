require 'test_helper'

class TestModelUghsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => TestModelUgh.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    TestModelUgh.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    TestModelUgh.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to test_model_ugh_url(assigns(:test_model_ugh))
  end
  
  def test_edit
    get :edit, :id => TestModelUgh.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    TestModelUgh.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TestModelUgh.first
    assert_template 'edit'
  end

  def test_update_valid
    TestModelUgh.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TestModelUgh.first
    assert_redirected_to test_model_ugh_url(assigns(:test_model_ugh))
  end
  
  def test_destroy
    test_model_ugh = TestModelUgh.first
    delete :destroy, :id => test_model_ugh
    assert_redirected_to test_model_ughs_url
    assert !TestModelUgh.exists?(test_model_ugh.id)
  end
end

require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before { @user = create(:user) }

  describe "GET index" do
    it "should render success and assign instance variables" do
      get :index
      expect(response).to have_http_status(:success)
      assigns(:per_page).should == 100
      assigns(:array).size.should == 100

      get :index, :format => :json
      expect(response).to have_http_status(:success)
      assigns(:per_page).should == 100
      assigns(:array).size.should == 100
    end
  end

  describe "PUT update" do
    it "should create number and render success" do
      put :update, id: @user.id, number: 56
      expect(response).to have_http_status(:success)

      put :update, id: @user.id, number: 88, :format => :json
      expect(response).to have_http_status(:success)

      # response.body.should === @user.numbers.to_json
    end
  end

  describe "GET show" do
    it "should render user numbers json " do
      get :show, id: @user.id
      expect(response).to have_http_status(:success)
      response.body.should === @user.to_json(:include => [:numbers])
    end
  end

  describe "POST create" do
    it "should create user " do
      post :create, :user => {last_name: 'philips', first_name: 'sam'}, :format => :json
      expect(response).to have_http_status(:success)
      expect(User.find_by_last_name('philips').nil?).to eq(false)
    end
  end
end

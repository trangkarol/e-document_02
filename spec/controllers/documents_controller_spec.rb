require "rails_helper"

RSpec.describe DocumentsController, type: :controller do
  let(:category) {FactoryGirl.create(:category)}
  before :each do
    login_user
    @document = FactoryGirl.create(:document, user_id: subject.current_user.id, category_id: category.id)
  end

  describe "Get Index" do
    it "when get index is successfully" do
      get :index, params: {user_id: subject.current_user.id}
    end
  end

  describe "Get show" do
    it "when get show is successfully" do
      get :show, params: {user_id: subject.current_user.id, id: @document.id}
      expect(response).to render_template(:show)
    end

    it "when get show is fail" do
      get :show, params: {user_id: subject.current_user.id, id: 0}
      assert_redirected_to root_path
    end
  end

  describe "Get new" do
    it "when get new is successfully" do
      get :new, params: {user_id: subject.current_user.id}
      expect(response).to render_template(:new)
    end
  end

  describe "Post create" do
    it "when create a document is successfully" do
      document = {
        name: Faker::Name.name,
        number_download: 0,
        file: Rack::Test::UploadedFile.new(File.open('./app/assets/images/default.pdf')),
        description: Faker::Lorem.sentence(6),
        size: 1000,
        status: Random.rand(0..2),
        category_id: category.id
      }

      post :create, params: {user_id: subject.current_user.id, document: document}
      expect(response.status).to eq(302)
    end
  end

  describe "Get edit" do
    it "when get edit is successfully" do
      get :edit, params: {user_id: subject.current_user.id, id: @document.id}
      expect(response).to render_template(:edit)
    end
  end

  describe "Put update" do
    it "when update a document is successfully" do
      @document.name = Faker::Name.name
      put :update, params: {user_id: subject.current_user.id, id: @document.id, document: @document}
      expect(response.status).to eq(204)
    end
  end

  describe "Delete update" do
    it "when delete a document is successfully" do
      delete :destroy, params: {user_id: subject.current_user.id, id: @document.id}
      expect(response.status).to eq(302)
    end
  end
end


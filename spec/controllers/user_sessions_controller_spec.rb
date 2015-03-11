require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  it "renders the new template" do
    get 'new'
    expect(response).to render_template('new')
  end

  describe "POST 'create'" do
    context "with correct credentials" do
    let!(:user) {User.create(first_name: "myname", last_name: "lastname", email: "email@gmail.com", password: "password", password_confirmation: "password")}  
    # it "returns http success" do
    #   get 'create'
    #   response.should be_success
    # end
      it "redirects to the todo list path" do
        post :create, email: "email@gmail.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({email: "email@gmail.com"}).and_return(user)
        post :create, email: "email@gmail.com", password: "password"
      end

      it "authenticates the user" do
        # user = User.create(first_name: "myname", last_name: "lastname", email: "email@gmail.com", password: "password", password_confirmation: "password")
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "email@gmail.com", password: "password"
      end

      it "sets the user ID in the session" do
        post :create, email: "email@gmail.com", password: "password"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets a flash success message" do
        post :create, email: "email@gmail.com", password: "password"
        expect(flash[:success]).to eq("thanks for logging in")
      end
    end
    context "with blank credentials" do
      
      it "renders the new template" do
        post :create
        expect(response).to render_template('new')
      end

      it "sets the flash error message" do
        post :create
        expect(flash[:error]).to eq("login unsuccessful")
      end
    end
    context "with incorrect credentials" do
      let!(:user) {User.create(first_name: "myname", last_name: "lastname", email: "email@gmail.com", password: "password", password_confirmation: "password")}  
      it "renders the new template" do
        post :create, email: "otheremail@email.com", password: ""
        expect(response).to render_template('new')
      end

      it "sets the flash error message" do
        post :create
        expect(flash[:error]).to eq("login unsuccessful")
      end
    end
  end

end


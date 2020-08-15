require 'rails_helper'

RSpec.describe "Admin actions", :type => :request do
	before(:each) { admin = create(:admin);  login_as(admin) }


  describe "Add user" do 
    describe "with valid params" do 
      user_params = {name: 'komait', email: 'komait@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'}

      it "should be add user" do
        post '/users' , params: {user: user_params }
        expect(response).to redirect_to('/users')
        follow_redirect!
        expect(response.body).to include("User added successfully")
        expect(response.body).to include('<p class="card-text">Email: komait@gmail.com</p>')
      end

      it "should add new user to database" do 
        expect { post '/users' , params: {user: user_params} }.to change(User, :count).from(1).to(2)
      end
    end
    describe "with invalid params" do 
      context "Name" do 
        user_params = {name: 'komait', email: 'komait@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'}

        it "ensure name to be valid format" do 
          user_params[:name] =  "@invalid@"
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>name has invalid format</li>")
        end

        it "ensure name to be presence" do 
          user_params[:name] = ""
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>name must be filled</li>")
        end
      end
      context "Email" do 
        user_params = {name: 'komait', email: 'komait@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'}
        it "ensure email to be presence" do 
          user_params[:email] = ""
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>email must be filled</li>")
        end

        it "ensure email to be valid format" do 
          user_params[:email] = "#invalid"
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>email has invalid format</li>")
        end
        it "ensure email to be uniqeness" do 
          old_user = create(:user)
          user_params[:email] = old_user.email
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>email has been taken</li>")
        end
      end
      context "Password" do 
        user_params = {name: 'komait', email: 'komait@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'}
        it "ensure password to be presence" do 
          user_params[:password] = ""
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>password must be filled</li>")
        end

        it "ensure password to be 6 digits at least" do 
          user_params[:password] = "12345"
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>password size cannot be less than 6</li>")
        end

        it "ensure password confirmation to match password" do
          user_params[:password] = "123456"          
          user_params[:password_confirmation] = "123455"
          post '/users' , params: {user: user_params}
          expect(response).to render_template('new')
          expect(response.body).to include("<li>password confirmation does not match password</li>")
        end
      end
    end
  end

  describe "Update user" do 
    context "with valid params" do 
      it "should updated" do
        user1 = create(:user)
        patch "/users/#{user1.id}" , params: {user: {name: 'komaitUpdated', email: 'komaitUpdated@gmail.com', phone: user1.phone, mobile: user1.mobile}}
        expect(response).to redirect_to('/users')
        follow_redirect!
        expect(response.body).to include("Update completed")
        expect(response.body).to include('<p class="card-text">Email: komaitupdated@gmail.com</p>')
      end
      context "with invalid params" do 
        it "should not updated" do
          user1 = create(:user)
          user2 = create(:user)
          patch "/users/#{user1.id}" , params: {user: {name: 'komaitUpdated', email: "#{user2.email}", phone: user1.phone, mobile: user1.mobile}}
          expect(response).to render_template('edit')
          expect(response.body).to include("Email has been taken")
        end

        it "should not update admin" do
          user1 = create(:admin)
          get "/users/#{user1.id}/edit"
          expect(response).to redirect_to('/users')
          follow_redirect!
          expect(response.body).to include("Can&#39;t edit admin")
        end


      end

    end
  end

  describe "Delete User" do
    it "should be delete user" do 
      user = create(:user)
      delete "/users/#{user.id}"
      expect(response).to redirect_to('/users')
      follow_redirect!
      expect(response.body).to include("User has been deleted")
      expect(User.count).to eq(1)
    end
    it "should not delete admin" do 
      user2 = create(:admin)
      delete "/users/#{user2.id}"
      expect(response).to redirect_to('/users')
      follow_redirect!
      expect(response.body).to include("Can&#39;t delete admin")
      expect(User.count).to eq(2)
    end
  end


end



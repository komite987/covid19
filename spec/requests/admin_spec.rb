require 'rails_helper'

RSpec.describe "Admin actions", :type => :request do
  before(:each) { admin = create(:admin);  login_as(admin) }
  before(:each) do
    @user_params = {name: 'komait', email: 'komait@gmail.com', mobile:'0988323323', phone: '04188008800', password: '123456', password_confirmation: '123456'} 
  end

  describe "Add user" do 
    context "When admin is login" do
      context "with valid user params" do 
        it "add the user successfully" do
          post '/users' , params: {user: @user_params }
          expect(response).to redirect_to('/users')
          follow_redirect!
          expect(response.body).to include("User added successfully")
          expect(response.body).to include('<p class="card-text">Email: komait@gmail.com</p>')
        end

        it "should add new user to database" do 
          expect { post '/users' , params: {user: @user_params} }.to change(User, :count).from(1).to(2)
        end
      end
      context "with invalid params" do 
        context "Name attribute" do 
          it "fail if name format invalid" do 
            @user_params[:name] =  "@invalid@"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>name has invalid format</li>")
          end

          it "fail if name is empty" do 
            @user_params[:name] = ""
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>name must be filled</li>")
          end
        end
        context "Email attribute" do 
          it "fail if email is empty" do 
            @user_params[:email] = ""
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>email must be filled</li>")
          end

          it "fail if email format invalid" do 
            @user_params[:email] = "#invalid"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>email has invalid format</li>")
          end
          it "fail if email is already taken" do 
            old_user = create(:user)
            @user_params[:email] = old_user.email
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>email has been taken</li>")
          end
        end
        context "Password attribute" do 
          it "fail if password is empty" do 
            @user_params[:password] = ""
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>password must be filled</li>")
          end

          it "fail if password is less than 6 digits" do 
            @user_params[:password] = "12345"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>password size cannot be less than 6</li>")
          end

          it "fail if password confirmation doesn't match password" do
            @user_params[:password] = "123456"          
            @user_params[:password_confirmation] = "123455"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>password confirmation does not match password</li>")
          end
        end
        context "Mobile attribute" do 
          it "fail if mobile format invalid" do 
            @user_params[:mobile] =  "0988trr432"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>mobile has invalid format</li>")
          end

          it "fail if mobile is empty" do 
            @user_params[:mobile] = ""
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>mobile must be filled</li>")
          end
        end
        context "Phone attribute" do 
          it "fail if phone format invalid" do 
            @user_params[:phone] =  "041880trr432"
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>phone has invalid format</li>")
          end

          it "fail if phone is empty" do 
            @user_params[:phone] = ""
            post '/users' , params: {user: @user_params}
            expect(response).to render_template('new')
            expect(response.body).to include("<li>phone must be filled</li>")
          end
        end

      end
    end

    context "When admin is not login" do
      it "fail to add user" do
        logout
        user = create(:user)
        login_as(user)
        post '/users' , params: {user: @user_params }
        expect(response).to render_template('searches/home')
        expect(response.body).to include("Only admins can do this")
      end
    end
  end

  describe "Update user" do 
    context "When admin is login" do
      context "with valid params" do 
        it "update user successfully" do
          user1 = create(:user)
          patch "/users/#{user1.id}" , params: {user: {name: 'komaitUpdated', email: 'komaitUpdated@gmail.com'}}
          expect(response).to redirect_to('/users')
          follow_redirect!
          expect(response.body).to include("Update completed")
          expect(response.body).to include('<p class="card-text">Email: komaitupdated@gmail.com</p>')
        end
      end
      context "with invalid params" do 
        it "fail to update user" do
          user1 = create(:user)
          user2 = create(:user)
          patch "/users/#{user1.id}" , params: {user: {name: 'komaitUpdated', email: "#{user2.email}", phone: user1.phone, mobile: user1.mobile}}
          expect(response).to render_template('edit')
          expect(response.body).to include("Email has been taken")
        end
      end
      context "When try to edit another admin" do
        it "fail to update admin" do
          user1 = create(:admin)
          get "/users/#{user1.id}/edit"
          expect(response).to redirect_to('/users')
          follow_redirect!
          expect(response.body).to include("Can&#39;t edit admin")
        end
      end
    end
    context "When admin is not login" do
      it "fail to update user" do
        logout
        user = create(:user)
        login_as(user)
        new_user = create(:user)
        patch "/users/#{new_user.id}" , params: {user: {name: 'UpdatedName', email: 'UpdatedEmail@gmail.com'}}
        expect(response).to render_template('searches/home')
        expect(response.body).to include("Only admins can do this")
      end
    end
  end

  describe "Delete User" do
    context "When admin is login" do
      it "delete user successfully" do 
        user = create(:user)
        delete "/users/#{user.id}"
        expect(response).to redirect_to('/users')
        follow_redirect!
        expect(response.body).to include("User has been deleted")
        expect(User.count).to eq(1)
      end
      it "fail to delete another admin" do 
        user2 = create(:admin)
        delete "/users/#{user2.id}"
        expect(response).to redirect_to('/users')
        follow_redirect!
        expect(response.body).to include("Can&#39;t delete admin")
        expect(User.count).to eq(2)
      end
    end
    context "When admin is not login" do
      it "fail to update user" do
        logout
        user = create(:user)
        login_as(user)
        new_user = create(:user)
        delete "/users/#{new_user.id}"
        expect(response).to render_template('searches/home')
        expect(response.body).to include("Only admins can do this")
      end

    end
  end

end



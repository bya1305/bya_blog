require "rails_helper"

RSpec.describe "Comments", type: :request do
  before do
    @user = User.create(email: "test@test.com", password: "password", password_confirmation: "password")
    @user2 = User.create(email: "test2@test.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "New Post", body: "Nice body", user: @user)
  end

  describe 'POST /posts/:id/comments' do
    context 'with a non signed in user' do
      before do
        post "/posts/#{@post.id}/comments", params: { comment: {body: "Sick comment!"}}
      end

      it "redirects user to the sign in page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with a logged in user' do
      before do
        login_as(@user2)
        post "/posts/#{@post.id}/comments", params: { comment: {body: "Sick comment!"}}
      end

      it "creates the comment successfully" do
        flash_message = "Comment has been created!"
        expect(response).to redirect_to(post_path(@post.id))
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq(flash_message)
      end
    end
  end
end

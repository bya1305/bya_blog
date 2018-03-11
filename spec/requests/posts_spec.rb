require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(email: "test2@test.com", password: "password", password_confirmation: "password")
    @post = Post.create!(title: "Title 1", body: "Body of article", user: @user)
  end

  describe 'GET /posts/:id' do

    context 'with existing post' do
      before {get "/posts/#{@post.id}" }

      it 'handles existing post' do
        expect(response.status).to eq(200)
      end
    end

    context 'with non-existent post' do
      before { get "/posts/xxxx" }

      it "handles non-existing post" do
        expect(response.status).to eq(302)
        flash_message = "The post you are looking for could not be found"
        expect(flash[:alert]).to eq(flash_message)
      end
    end

  end

  describe 'GET /post/:id/edit' do

    context 'with non-signed in user' do
      before { get "/posts/#{@post.id}/edit" }

      it "redirects to the sign in page" do
        expect(response.status).to eq(302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with non-owner of post' do
      before do
        login_as(@user2)
        get "/posts/#{@post.id}/edit"
      end

      it "redirects to the homepage" do
        expect(response.status).to eq(302)
        flash_message = "You can only edit your own posts"
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in owner of post - successful edit' do
      before do
        login_as(@user)
        get "/posts/#{@post.id}/edit"
      end

      it "successfully edits post" do
        expect(response.status).to eq(200)
      end
    end

  end
end

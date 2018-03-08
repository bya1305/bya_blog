require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @post = Post.create(title: "Title 1", body: "Body of article")
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
end

require 'rails_helper'

RSpec.feature "Delete a Post" do
  before do
    user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
    login_as(user)
    @post = Post.create(title: "New Post Title", body: "This is the body", user: user)
  end

  scenario "User deletes a post" do
    visit root_path
    click_link @post.title
    click_link "Delete Post"

    expect(page).to have_content("Post has been deleted!")
    expect(current_path).to eq(posts_path)
  end
end

require 'rails_helper'

RSpec.feature "Delete a Post" do
  before do
    @post = Post.create(title: "New Post Title", body: "This is the body")
  end

  scenario "User deletes a post" do
    visit root_path
    click_link @post.title
    click_link "Delete Post"

    expect(page).to have_content("Post has been deleted!")
    expect(current_path).to eq(posts_path)
  end
end

require 'rails_helper'

RSpec.feature "Editing a Post" do

  before do
    user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
    login_as(user)
    @post = Post.create(title: "Edit A Post Title", body: "This is the body of the post", user: user)
  end

  scenario "User updates a post" do
    visit root_path
    click_link @post.title
    click_link "Edit Post"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body"
    click_button "Update Post"

    expect(page).to have_content("Post has been updated!")
    expect(page.current_path).to eq(post_path(@post))
  end

  scenario "User fails to update a post" do
    visit root_path
    click_link @post.title
    click_link "Edit Post"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body"
    click_button "Update Post"

    expect(page).to have_content("Post was not updated =(")
    expect(page.current_path).to eq(post_path(@post))
  end

end

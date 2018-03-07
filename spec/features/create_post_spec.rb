require "rails_helper"

RSpec.feature "Create a post" do
  scenario "A user creates a new post" do
    visit root_path
    click_link "New Post"
    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Post"

    expect(page).to have_content("New Post Created Successfully!")
    expect(page.current_path).to eq(posts_path)
  end



end

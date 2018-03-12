require "rails_helper"

RSpec.feature "Adding comments to posts" do
  before do
    @user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(email: "test2@test.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "This is a show page post title", body: "This is the post body for our show page test", user: @user)
  end

  scenario "allow a signed in user to comment on post" do
    login_as(@user2)
    visit root_path
    click_link(@post.title)
    fill_in "New Comment", with: "Such an awesome post!"
    click_button("Add Comment")

    
    expect(page).to have_content("Such an awesome post!")
    expect(current_path).to eq(post_path(@post))
  end
end

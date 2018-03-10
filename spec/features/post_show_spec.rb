require 'rails_helper'

RSpec.feature "Show a Post on its own page" do
  before do
    @user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(email: "test2@test.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "This is a show page post title", body: "This is the post body for our show page test", user: @user)
  end

  scenario "A user can view a Post's show page" do
    visit root_path
    click_link @post.title

    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.body)
    expect(current_path).to eq(post_path(@post))
  end

  scenario "A user can't see the edit or delete button unless signed in" do
    visit root_path
    click_link @post.title

    expect(page).not_to have_link("Edit Post")
    expect(page).not_to have_link("Delete Post")
  end

  scenario "A user can only see edit and delete post buttons if they created the post" do
    login_as(@user2)
    visit root_path
    click_link @post.title

    expect(page).not_to have_link("Edit Post")
    expect(page).not_to have_link("Delete Post")
  end

  scenario "An owner can see the edit and delete buttons on show page" do
    login_as(@user)
    visit root_path
    click_link @post.title

    expect(page).to have_link("Edit Post")
    expect(page).to have_link("Delete Post")
  end
end

require 'rails_helper'

RSpec.feature "Show a Post on its own page" do
  before do
    @post = Post.create(title: "This is a show page post title", body: "This is the post body for our show page test")
  end

  scenario "A user can view a Post's show page" do
    visit root_path
    click_link @post.title

    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.body)
    expect(current_path).to eq(post_path(@post))
  end
end
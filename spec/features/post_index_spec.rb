require 'rails_helper'

RSpec.feature "Index of Blog Posts" do

  before do
    @post1 = Post.create!(title: "Game of Thrones is the best show ever!", body: "I can go on and on about this show")
    @post2 = Post.create!(title: "Can't stop coding", body: "I love creating projects with the things I've learned about coding!")
  end

  scenario "An index of blog posts is shown" do
    visit root_path

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_link(@post1.title)
    expect(page).to have_link(@post2.title)

  end

  scenario "No blog posts for index" do
    Post.delete_all

    visit root_path

    expect(page).not_to have_content(@post1.title)
    expect(page).not_to have_content(@post2.title)
    expect(page).not_to have_link(@post1.title)
    expect(page).not_to have_link(@post2.title)

    within ("h1#no-posts") do
      expect(page).to have_content("No blog posts have been created!")
    end
  end
end

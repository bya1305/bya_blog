require "rails_helper"

RSpec.feature "User can sign in" do
  before do
    @mark = User.create!(email: "mark@example.com", password: "password", password_confirmation: "password")
  end

  scenario "with valid credentials" do
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: @mark.email
    fill_in "Password", with: @mark.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@mark.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end
end

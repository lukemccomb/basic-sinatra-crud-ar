feature "homepage" do
  before(:each) do
    visit "/"
  end
  scenario "visitor visits homepage" do
    skip
    expect(page).to have_link("Register")
  end
  scenario "visit registration page" do
    skip
    click_link "Register"
    expect(page).to have_content("Username:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
  end
  scenario "register new user" do
    skip
    click_link "Register"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Submit"
    expect(page).to have_content("Thank you for registering")
  end
  scenario "login user" do
    skip
    click_link "Register"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Submit"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Log In"
    # save_and_open_page
    expect(page).to have_content("Welcome, peter")
  end
  scenario "logged in user" do
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Log In"
    click_link "Logout"
    expect(page).to have_link("Register")
  end
end
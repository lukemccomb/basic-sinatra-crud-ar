feature "homepage" do
  before(:each) do
    visit "/"
  end
  scenario "visitor visits homepage" do
    expect(page).to have_link("Register")
  end
  scenario "visit registration page" do
    click_link "Register"
    expect(page).to have_content("Username:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
  end
  scenario "register new user" do
    click_link "Register"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Submit"
    expect(page).to have_content("Thank you for registering")
  end
end
feature "register" do
  before(:each) do
    visit "/register/"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Submit"
  end
  scenario "login user" do
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
  scenario "register validation" do
    click_link "Register"
    click_button "Submit"
    expect(page).to have_content("Please enter a username and password.")
    fill_in "username", :with => "peter"
    click_button "Submit"
    expect(page).to have_content("Please enter a password.")
    fill_in "username", :with => ""
    fill_in "password", :with => "luke"
    click_button "Submit"
    expect(page).to have_content("Please enter a username.")
  end
end
feature "many users" do
  before(:each) do
    visit "/register/"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Submit"
    visit "/register/"
    fill_in "username", :with => "lindsay"
    fill_in "password", :with => "luke"
    click_button "Submit"
    visit "/register/"
    fill_in "username", :with => "jeff"
    fill_in "password", :with => "luke"
    click_button "Submit"
    fill_in "username", :with => "peter"
    fill_in "password", :with => "luke"
    click_button "Log In"
  end
  scenario "see usernames on login" do
    expect(page).to have_content("lindsay jeff")
  end
  scenario "click sort button to sort alphabetize usernames" do
    select "Descending", from: "sort"
    click_button "Sort"
    expect(page).to have_content("lindsay jeff")
    select "Ascending", from: "sort"
    click_button "Sort"
    expect(page).to have_content("jeff lindsay")
  end
  scenario "deletes users successfully" do
    fill_in "delete", :with => "jeff"
    click_button "Delete"
    expect(page).to have_no_content("jeff")
  end
  scenario "adds fish to fish table" do
    fill_in "name", :with => "fur-bearing trout"
    fill_in "wiki", :with => "http://en.wikipedia.org/wiki/Fur-bearing_trout"
    click_button "Add Fish"
    expect(page).to have_link("fur-bearing trout", :href =>"http://en.wikipedia.org/wiki/Fur-bearing_trout")
  end
  scenario "user only sees user fish" do
    fill_in "name", :with => "fur-bearing trout"
    fill_in "wiki", :with => "http://en.wikipedia.org/wiki/Fur-bearing_trout"
    click_button "Add Fish"
    click_link "Logout"
    fill_in "username", :with => "lindsay"
    fill_in "password", :with => "luke"
    click_button "Log In"
    fill_in "name", :with => "Salmon of Knowledge"
    fill_in "wiki", :with => "http://en.wikipedia.org/wiki/Salmon_of_Knowledge"
    click_button "Add Fish"
    expect(page).to have_link("Salmon of Knowledge", :href =>"http://en.wikipedia.org/wiki/Salmon_of_Knowledge")
    expect(page).to have_no_content("fur-bearing trout")
  end
end
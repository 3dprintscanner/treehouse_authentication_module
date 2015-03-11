require 'spec_helper'



describe "Signing up" do

	it "allows a user to sign up for the site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"


		fill_in "First Name", with: "firstname"
		fill_in "Last Name", with: "lastname"
		fill_in "Email", with: "firstname@lastname.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign Up"

	end
	
end
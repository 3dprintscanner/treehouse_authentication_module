require 'spec_helper'



describe 'Logging in' do
	it "displays the email address with a failed login" do
		visit new_user_session_path
		fill_in "Email", with: "jason@teamtreehouse.com"
		fill_in "Password", with: "incorrect"
		click_button "Log In"

		expect(page).to have_content("login unsuccessful")
		expect(page).to have_field("Email", with: "jason@teamtreehouse.com")
	end

	it "logs the user in and goes to the todo lists" do
		User.create(first_name: "Jason", last_name: "Seifer", email: "jason@teamtreehouse.com", password: "password", password_confirmation: "password")
		visit new_user_session_path

		fill_in "Email", with: "jason@teamtreehouse.com"
		fill_in "Password", with: "password"
		click_button "Log In"

		expect(page).to have_content("Todo Lists")
		expect(page).to have_content("thanks for logging in")
		
	end

	
end
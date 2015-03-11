module AuthenticationHelpers
	def sign_in(user)
		controller.stub(:current_user).and_return(build_stubbed(:user))
end

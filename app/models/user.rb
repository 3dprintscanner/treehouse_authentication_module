class User < ActiveRecord::Base
	has_secure_password
	validates :email, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\z/ }

	before_save :downcase_email

	# attr_accessor :password, :password_confirmation



	def downcase_email
		self.email = email.downcase
	end

end

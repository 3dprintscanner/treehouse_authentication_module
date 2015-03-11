class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
	  	session[:user_id] = user.id
	  	flash[:success] = "thanks for logging in"
	  	redirect_to todo_lists_path
	else
		flash[:error] = "login unsuccessful"
		render action: 'new'
	end
  end
end

class LoginsController < ApplicationController
  
  #To display the login form
  def new
  	@client = Client.new
  end

  #To authenticate login
  def create
  	@login_details = Client.login_check(params[:client][:username], params[:client][:password])

  	if !@login_details.blank?
		  redirect_to(client_path(@login_details[0].id))
	  else
		  flash[:error] = 'Invalid Username or Password'
		  redirect_to('/')
	  end

  end

  def show
  end

private

  def login_params
    params.require(:client).permit(:username, :password)
  end

end

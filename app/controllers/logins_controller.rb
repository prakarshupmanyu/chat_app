class LoginsController < ApplicationController
  
  #To display the login form
  def new
  	@client = Client.new
    @page_title = "Login"
  end

  #To authenticate login
  def create

    if params[:client][:username].present? && params[:client][:password].present?
  	  
      @login_details = Client.login_check(params[:client][:username]).first

  	  if @login_details && @login_details.authenticate(params[:client][:password])
        session[:user_id] = @login_details.id
        flash[:notice] = "You are now logged in"
		    redirect_to(client_path(@login_details.id))
	    else
		    flash[:error] = 'Invalid Username or Password'
		    redirect_to('/')
	    end
    else
      flash[:error] = "Please provide both username and password"
      redirect_to('/')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to('/')
  end


private

  def login_params
    params.require(:client).permit(:username, :password)
  end

end

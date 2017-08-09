class RegistrationsController < ApplicationController
  
  #Display the registration form
  def new
  	@client = Client.new
  end

  #Save registration details
  def create
  	@client = Client.new(register_params)
  	if @client.save
  		flash[:notice] = "Client registered succesfully. You can login now."
  		redirect_to(new_login_path)
  	else
  		flash[:error] = 'Could not register. Please check errors.'
		redirect_to(new_registration_path)
  	end
  end

  def show
  end

  private

  def register_params
  	params.require(:client).permit(:first_name, :last_name, :age, :email, :client_type, :date_of_birth, :username, :password)
  end
end

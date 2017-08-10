class ClientsController < ApplicationController

  before_action :confirm_logged_in, :only => [:show]

  #Display the registration form
  def new
  	@client = Client.new
    @page_title = "Registration"
  end

  #Save registration details
  def create
  	@client = Client.new(register_params)
  	if @client.save
  		flash[:notice] = "Client registered succesfully. You can login now."
  		redirect_to(new_login_path)
  	else
  		#flash[:error] = @client.errors.messages
		  render('new')
  	end
  end

  #show the client home page
  def show
    #puts(session[:user_id])
  	@client = Client.find_by_id(params[:id])
    @page_title = "Home"
    if @client.blank?
      redirect_to('/404.html')
    end
  end

  private

  def register_params
  	params.require(:client).permit(:first_name, :last_name, :age, :email, :client_type, :date_of_birth, :username, :password)
  end
  
  def confirm_logged_in
    if session[:user_id].blank?
      flash[:notice] = "Please log in"
      redirect_to('/')
    end
    if session[:user_id] != params[:id].to_i
      flash[:notice] = "You tried to view someone else's account. This is not allowed."
      params[:id] = session[:user_id]
      redirect_to(client_path(params[:id]))
    end
  end

end

class ChatsController < ApplicationController

  before_action :confirm_logged_in

  def new
  	@message = Message.new(:message => "Hi! Let's chat.")
  	#for new chat
    @ecc = existing_chat_clients(params[:id])
    if @ecc.blank?
      exclude_client_id_string = params[:id]
    else
      exclude_client_id_string = @ecc + "," + params[:id]
    end
    @ncc = get_new_chat_clients(exclude_client_id_string)
    if @ncc.blank?
      @no_more_users_to_chat = "We couldn't find any more users to chat. Either you already have an existing chat with all of them or you are too lonely :P"
    end
    @sender_id = params[:id]
  end

  def create
    message = Message.new(chat_params)
    chat = Chat.new
    chat.client1 = message.sender
    chat.client2 = message.receiver
    chat.num_messages = 1
    if chat.save
      m = chat.messages << message
      if m.blank?
        flash[:error] = "Your message was not sent."
        redirect_to(new_chat_path)
      else
        #message sent successfully. Show chat page
        receiver = Client.find_by_id(message.receiver)
        receiver_name = receiver.first_name + " (" + receiver.client_type + ")"
        flash[:notice] = "Your chat with #{receiver_name} has started."
        redirect_to(edit_chat_path(m[0].chat_id))
      end
    else
      #Chat could not be saved successfully
      flash[:error] = "Your chat was not sent."
      redirect_to(new_chat_path)
    end

  end

  def show
    #get the client ID comma separated string with which the currently logged in client
  	@client_ids = existing_chat_clients(params[:id])
    @user_id = params[:id]
  	if @client_ids.blank?
  		#show that no chat
  		@no_chat_message = "Sorry! We can't find any chat where you are involved."
  	else
  		#show chats. collect all client IDs with whom the user has chatted
      @chat_clients = Client.where(["id IN (?)", @client_ids])
    end
  end

  def edit
    @chat_id = params[:chat_id]
  end

  private

  def chat_params
    params.require(:message).permit(:receiver, :message, :sender)
  end

  def get_new_chat_clients(existing_client_str)
    ncc = Client.where("id NOT IN (#{existing_client_str})")
    ncc
  end

  def existing_chat_clients(client_id)
    chat_list_1 = Chat.select(:client2).chat_client1(client_id)
    chat_list_2 = Chat.select(:client1).chat_client2(client_id)
    chat_list_1.each do |c|
      (@c_ids ||= []) << c.client2
    end
    chat_list_2.each do |c|
      (@c_ids ||= []) << c.client1
    end
    client_ids = ''
    if !@c_ids.blank?
     client_ids = @c_ids.join(",")
    end
    client_ids
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to('/')
    end
  end

end

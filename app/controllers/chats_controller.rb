class ChatsController < ApplicationController

  before_action :confirm_logged_in

  def new
  	@message = Message.new(:message => "Hi! Let's chat.")
  	#for new chat
    @page_title = "New chat"
    @ecc, @chat_ids = existing_chat_details(params[:id])
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
        chat.destroy
        flash[:error] = "Your message was not sent."
        redirect_to(new_chat_path(:id => message.sender))
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
      redirect_to(new_chat_path(:id => message.sender))
    end

  end

  def show

    if session[:user_id] != params[:id].to_i
      flash[:notice] = "You are not allowed to view chat list of other clients."
      redirect_to(chat_path(session[:user_id]))
    end

    @page_title = "Your chats"
    #get the client ID comma separated string with which the currently logged in client
  	@client_ids, @chat_ids = existing_chat_details(params[:id])
    @user_id = params[:id]
  	if @client_ids.blank?
  		#show that no chat
  		@no_chat_message = "Sorry! We can't find any chat where you are involved."
  	else
  		#show chats. collect all client IDs with whom the user has chatted
      
      @chat_clients = Client.where("id IN (#{@client_ids})")
    end
  end

  def edit
    @chat_id = params[:id]
    @messages = Message.get_chat_messages(@chat_id)
    @curr_user_id = session[:user_id]

    @chat_client_name = {}
    @chat_client_name[@curr_user_id] = Client.find_by_id(@curr_user_id).first_name

    @chat_details = Chat.find_by_id(@chat_id)
    
    if @curr_user_id == @chat_details.client1
      @chat_client_name[@chat_details.client2] = Client.find_by_id(@chat_details.client2).first_name
      @other_user_id = @chat_details.client2
    else
      @chat_client_name[@chat_details.client1] = Client.find_by_id(@chat_details.client1).first_name
      @other_user_id = @chat_details.client1
    end
    @page_title = "Your chat with #{@chat_client_name[@other_user_id]}"
    @msg = Message.new
  end

  private

  def chat_params
    params.require(:message).permit(:receiver, :message, :sender)
  end

  def get_new_chat_clients(existing_client_str)
    ncc = Client.where("id NOT IN (#{existing_client_str})")
    ncc
  end

  def existing_chat_details(client_id)
    chat_list_1 = Chat.select(:client2, :id).chat_client1(client_id)
    chat_list_2 = Chat.select(:client1, :id).chat_client2(client_id)

    @chat_ids = {}

    chat_list_1.each do |c|
      (@c_ids ||= []) << c.client2
      @chat_ids[c.client2] = c.id
    end
    chat_list_2.each do |c|
      (@c_ids ||= []) << c.client1
      @chat_ids[c.client1] = c.id
    end

    client_ids = ''
    
    if !@c_ids.blank?
      client_ids = @c_ids.uniq.join(",")
    end
    
    return client_ids, @chat_ids
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to('/')
    end
  end

end

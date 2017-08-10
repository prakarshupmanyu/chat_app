class MessagesController < ApplicationController
	def create
		@msg = Message.new(message_params)
		if @msg.save
			#message sent. update chat table with num_messages and reload the chat window

			chat = Chat.find_by_id(@msg.chat_id)
			chat.num_messages = chat.num_messages + 1
			chat.save
			redirect_to(edit_chat_path(@msg.chat_id))
		else
			#message not saved. Reload chat window with flash message
			flash[:error] = "Message could not be sent."
			redirect_to(edit_chat_path(@msg.chat_id))
		end
	end

	private

  	def message_params
    	params.require(:message).permit(:receiver, :message, :sender, :chat_id)
  	end
end

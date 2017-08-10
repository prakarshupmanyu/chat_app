class Message < ApplicationRecord
	belongs_to :chat, {:foreign_key => "chat_id"}


	scope :get_chat_messages, lambda { |chat_id| where(["chat_id = ?", chat_id]).order("created_at") }

	validates :chat_id, :presence => true, :numericality => true

	validates :sender, :presence => true, :numericality => true
	validates :receiver, :presence => true, :numericality => true

	validates :message, :presence => true

end

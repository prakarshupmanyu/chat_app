class Message < ApplicationRecord
	belongs_to :chat, {:foreign_key => "chat_id"}

	validates :chat_id, :presence => true, :numericality => true

	validates :sender, :presence => true, :numericality => true
	validates :receiver, :presence => true, :numericality => true

	validates :message, :presence => true

end

class Chat < ApplicationRecord
	
	belongs_to :client, {:foreign_key => "client1"}
	has_many :messages

	scope :chat_client1, lambda { |client_id| where(:client1 => client_id) }
	scope :chat_client2, lambda { |client_id| where(:client2 => client_id) }

	validates :client1, :presence => true, :numericality => true
	
	validates :client2, :presence => true, :numericality => true
	
	validates :num_messages, :presence => true, :numericality => true
end

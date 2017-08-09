class Login < ApplicationRecord
	belongs_to :client, {:foreign_key => 'client_id'}
	
end

class Client < ApplicationRecord
	scope :login_check, lambda { |username, password| where(:username => username, :password => password)}

	validates_presence_of :username
	validates_presence_of :password

end

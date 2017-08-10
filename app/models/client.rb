class Client < ApplicationRecord

	has_secure_password

	has_many :chats

	scope :login_check, lambda { |username| where(:username => username)}

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :first_name, :presence => true, :length => { :maximum => 40 }
  	
  	validates :last_name, :presence => true, :length => { :maximum => 40 }
  	
  	validates :age, :presence => true, :numericality => true

  	validates :username, :presence => true, :length => { :maximum => 25, :minimum => 4 }, :uniqueness => true
  	
  	validates :password, :presence => true

  	validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
					:uniqueness => true                    

	validates :client_type, :presence => true, :inclusion => {:in => ['USER', 'TRAINER', 'ADMIN']}

end
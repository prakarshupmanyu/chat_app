Rails.application.routes.draw do
  
  root 'chatapp#login'

  get 'chatapp/login'

  get 'chatapp/register'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

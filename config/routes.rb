Rails.application.routes.draw do

  root 'logins#new'

  get 'logins/logout'

  resources :logins do
  	member do
  		get :delete
  	end
  end

  resources :clients do
    member do
      get :delete
    end
  end

  resources :chats do
    member do
      get :delete
    end
  end

  resources :messages do
    member do
      get :delete
    end
  end


  #get 'clients/new'

  #get 'clients/create'

  #get 'clients/show'

  #get 'registrations/new'

  #get 'registrations/create'

  #get 'registrations/show'

  #get 'logins/new'

  #get 'logins/create'

  #get 'logins/show'

  #get 'client/home'

  #get 'client/chats'

  #get 'login/login'

  #get 'registration/register'

  #post 'logins/auth_login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :users, :param => :id do
    resource :house
    resources :housing_adverts, :param => :id, :only => [:index, :show] 
    resources :housing_reservations, :param => :id
  end
  resources :conveniences, :param => :id
  resources :housing_adverts, :param => :id
  post '/auth/login', :to => 'authentication#login'
  get '/*a', :to => 'application#not_found'
end
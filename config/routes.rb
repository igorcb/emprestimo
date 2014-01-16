Emprestimo::Application.routes.draw do
  resources :sessions
  resources :item_advances, only: [:index, :update]
  match '/item_advance_by_cliente/:id', :controller=>'item_advances', :action => 'item_advance_by_cliente', via: [:get]
  namespace "api" do

    resources :cidades
    resources :clientes
    resources :advances, except: [:destroy]
    resources :item_advances
    resources :empresas do
      resources :advances, only: [:destroy]
    end
    post "cidades_uuid" => "cidades#cidades_uuid", :as => "cidades_uuid",  via: [:post]
    post "clientes_uuid" => "clientes#clientes_uuid", :as => "clientes_uuid",  via: [:post]
    #post "item_advances_today_and_city" => "item_advances#item_advances_today_and_city", :as => "item_advances_today_and_city",  via: [:post]
    post "item_advances_today_and_city" => "item_advances#item_advances_today_and_city",  via: [:post]
    get "is_active" => "servers#is_active", :as => "is_active", via: [:get]
  end
  #root to: 'item_advances#index'
  root to: 'sessions#new'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'  

end
 
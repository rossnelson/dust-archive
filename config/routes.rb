Dust::Application.routes.draw do
 
  
  get "sitemap/index"
  get "view_page/show"
  get "dashboard/show"
  
  get "search", :controller => "view_page", :as => :view_page_search #new! search

  resources :blocks
  resources :cms_menu_items
  resources :menu_items
  resources :keys
  resources :contacts
  resources :pages
  resources :testimonials
  resources :posts
  resources :slides
  resources :manage_slides, :only => [:create]
  resources :roles
  resources :users do
    member do
      get :activate
    end
  end
  resources :sessions
  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "reload_user" => "users#reload_user", :as => "reload_user"

  match "dashboard" => "dashboard#show", :as => :dashboard
  match "dashboard/update" => "dashboard#update", :as => :dashboard_update

  match 'menu-manage' => 'menu_items#manage', :as => :menu_manage

  match "sitemap" => "sitemap#index", :as => :sitemap_xml
  match ':filename' => 'view_page#show', :as => :view_page

  match 'download/csv' => 'contacts#csv', :as => :download_csv
  match 'import/csv' => 'contacts#csv_import', :as => :import_csv

  match 'cms_menu/array' => 'cms_menu_items#array', :as => :cms_menu_sort
  match 'menu/array' => 'menu_items#array', :as => :menu_sort
  
  mount Ckeditor::Engine => "/ckeditor"

  root :to => "view_page#show", :filename => "welcome"

end

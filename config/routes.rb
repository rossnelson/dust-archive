Dust::Application.routes.draw do

  mount Ckeditor::Engine => "/ckeditor"

  namespace :dust do

    resources :blocks
    resources :cms_menu_items
    resources :menu_items
    resources :contacts
    resources :pages
    resources :roles
    resources :users

    resources :sessions, :only => [:new, :create, :destroy]
    resources :password_resets, :only => [ :new, :create, :edit, :update ]

    get "dashboard/show" => "dashboard#show", :as => :dashboard
    match "dashboard/update" => "dashboard#update", :as => :dashboard_update

    match 'menu-manage' => 'menu_items#manage', :as => :menu_manage

    match 'download/csv' => 'contacts#csv', :as => :download_csv
    match 'import/csv' => 'contacts#csv_import', :as => :import_csv

    match 'cms_menu/array' => 'cms_menu_items#array', :as => :cms_menu_sort
    match 'menu/array' => 'menu_items#array', :as => :menu_sort

    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "signup" => "users#new", :as => "signup"

  end

  scope :module => 'front_end' do

    get "search", :controller => "view_page", :as => :view_page_search #new! search

    match "sitemap" => "sitemap#index", :as => :sitemap_xml
    match ':filename' => 'page#show', :as => :front_end_page

    root :to => "page#show", :filename => "welcome"

  end

end

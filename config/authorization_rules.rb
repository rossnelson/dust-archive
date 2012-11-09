authorization do
  role :admin do
    has_omnipotence
    
    has_permission_on [:dashboard, :blocks, :photos, :slides, :products, :categories, :view_pages, :pages, :contacts, :keys, :descriptions], :to => [:manage, :view]
    has_permission_on [:menu_items, :cms_menu_items], :to => [:manage, :view]
  end
  
  role :client do
    has_permission_on [:refinance_orders, :letter_report_orders, :real_estate_sale_orders], :to => :make
    
    has_permission_on :users, :to => [:alter, :view] do
      if_attribute :id => is {user.id}
    end
  end

  role :guest do
    has_permission_on [:view_pages], :to => :view
    has_permission_on [:contacts, :users], :to => :make
  end

  role :moderator do
    has_permission_on [:dashboard, :blocks, :photos, :slides, :products, :categories, :view_pages, :pages, :contacts, :keys, :descriptions], :to => [:manage, :view]
    has_permission_on [:menu_items], :to => :manage
    has_permission_on :users, :to => [:alter, :view] do
      if_attribute :id => is {user.id}
    end
  end
end

privileges do
  privilege :manage do
    includes :index, :show, :new, :create, :edit, :update, :destroy, :array, :childstuff
  end

  privilege :view do
    includes :index, :show, :dashboard
  end

  privilege :alter do
    includes :edit, :update, :show
  end
  
  privilege :make do
    includes :new, :create
  end
end
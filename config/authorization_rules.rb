authorization do
  role :admin do
    has_omnipotence
  end

  role :client do
    has_permission_on :users, :to => [:alter, :view] do
      if_attribute :id => is {user.id}
    end
  end

  role :guest do
    has_permission_on [:front_end], :to => :view
    has_permission_on [:dust_contacts], :to => :make
  end

  role :moderator do
    has_permission_on [:dashboard, :dust_blocks, :dust_photos, :dust_slides, :dust_products, :dust_categories, :dust_pages, :dust_contacts], :to => [:manage, :view]
    has_permission_on [:dust_menu_items], :to => :manage
    has_permission_on :dust_users, :to => [:alter, :view] do
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

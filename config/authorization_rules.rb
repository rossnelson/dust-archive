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
    has_permission_on [:dust_contacts], :to => :make
  end

  role :moderator do
    has_permission_on [:dust_gallery_albums, :dust_gallery_photos], :to => :manage
    has_permission_on [:dust_dashboard, :dust_pages, :dust_blocks, :dust_posts], :to => :manage
    has_permission_on [:dust_menus, :dust_menu_items, :dust_slides, :dust_contacts], :to => :manage

    has_permission_on :dust_users, :to => [:alter] do
      if_attribute :id => is {user.id}
    end
  end
end

privileges do
  privilege :manage do
    includes :index, :show, :new, :create, :edit, :update, :destroy, :sort
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

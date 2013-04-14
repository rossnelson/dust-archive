authorization do
  role :admin do
    has_omnipotence
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

module Dust
  class Engine < ::Rails::Engine

    initializer 'dust_engine.widget_view_paths', :after=> :disable_dependency_loading do |app|
      ActionController::Base.prepend_view_path File.join(Dust.root, "app/dust/views/widgets")
      ActionController::Base.prepend_view_path "app/views/widgets"
    end

  end
end

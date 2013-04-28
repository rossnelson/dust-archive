module Dust
  class Engine < ::Rails::Engine

    initializer 'dust_engine.widget_view_paths', :after=> :disable_dependency_loading do |app|
      ActionController::Base.prepend_view_path File.join(Dust.root, "app/dust/views/widgets")
      ActionController::Base.prepend_view_path "app/views/widgets"

      Dust::Application.config.assets.paths << "#{Dust.root}/app/assets/images"
      Dust::Application.config.assets.paths << "#{Dust.root}/app/assets/stylesheets"
      Dust::Application.config.assets.paths << "#{Dust.root}/app/assets/javascripts"
    end

  end
end

module Dust
  module Utils
    def select_assets(path, relative_path)
      folder = File.join(path, '**')
      relative_folder = Dust.root.join(relative_path)

      Dir[Dust.root.join(folder, '*.{js,css}')].inject([]) do |list, file|
        list << Pathname.new(file).relative_path_from(relative_folder).to_s
        list
      end
    end
  end
end


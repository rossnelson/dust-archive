class ApplicationController < AuthenticationController

  before_filter :load_sitewide_data, :meta_tags, :load_blocks

  def meta_tags
    @description = @site_data.site_info.default_description
  end

  # Loads blocks and groups them by position in the layout
  def load_blocks
    @blocks = Dust::Block.find_active(request.fullpath)
  end

  def load_sitewide_data
    @site_data = Dust::SiteWide.all_to_object
  end

end

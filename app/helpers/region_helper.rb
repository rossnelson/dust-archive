module RegionHelper

  def render_region(name, &block)
    @block_content = (block_given? ? block : @blocks.select{ |b| b.where_to_show == name })
    unless @block_content.blank?
      build_regions(name, (@block_content.class == Proc ? @block_content : render_block_wrappers))
    end
  end

  def build_regions(name, innards)
    @regions = region_wrapper("#{name}-blocks", "container-twelve", innards)
    @regions = region_wrapper("#{name}-blocks-container", "clearfix", @regions)
    @regions = region_wrapper("#{name}-blocks-wrapper", "cleafix", @regions)

    @regions
  end

  def region_wrapper(id, html_class, innards="")
    content_tag :div, :id => id, :class => html_class do
      innards.class == Proc ? innards.call : raw(innards)
    end
  end

  def render_block_wrappers
    @block_content.map! do |block|
      render(:partial => "dust/blocks/block", :locals => {:block => block})
    end
    @block_content.join("\n")
  end

end


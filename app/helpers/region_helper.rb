module RegionHelper

  def render_region(name, &block)
    @block_content = (block_given? ? block.call : @blocks.select{ |b| b.where_to_show == name })
    unless @block_content.empty? || @block_content.blank?
      build_regions name do
        blocks_html(@block_content)
      end
    end
  end

  def build_regions(name, &block)
    @regions = region_wrapper("#{name}-blocks", "container-twelve", raw(block.call))
    @regions = region_wrapper("#{name}-blocks-container", "clearfix", @regions)
    @regions = region_wrapper("#{name}-blocks-wrapper", "cleafix", @regions)

    @regions
  end

  def region_wrapper(id, html_class, innards="")
    content_tag :div, :id => id, :class => html_class do
      innards
    end
  end

  def blocks_html(blocks)
    blocks.class == Proc ? block.call : render_block_wrappers
  end

  def render_block_wrappers
    @block_content.map! do |block|
      render(:partial => "dust/blocks/block", :locals => {:block => block})
    end
    @block_content.join("\n")
  end

end


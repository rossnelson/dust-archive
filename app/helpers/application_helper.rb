module ApplicationHelper
	
	def create_description
		truncate(strip_tags(content), :length => 50)
	end
	
	def content_classes()
	  classes = ""
	  classes << @page.classes unless @page.nil? or @page.classes.nil?
	  classes
  end
  
  def edit_icon(type="")
    image_tag("ui/edit-icon.png", :class =>"brush tip", :title => "Edit #{type}")
  end
  
  def index_icon(type="")
    image_tag("ui/index-icon.png", :class =>"eye tip", :title => "Show All #{type}")
  end
  
  def new_icon(type="")
    image_tag("ui/new-icon.png", :class =>"eye tip", :title => "Create New #{type}")
  end
  
  def block_region(name)
    bunch_of_blocks = @blocks.select{ |b| b if b.where_to_show == name }
    render(:partial => "blocks/block_region", :locals => {:blocks => bunch_of_blocks, :name => name})
  end
end

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
    
  def render_region(name, &block)
    bunch_of_blocks = @blocks.select{ |b| b if b.where_to_show == name }
    if !bunch_of_blocks.empty? || block_given?
      capture_haml do
        haml_tag :div, :id => "#{name}-blocks-container", :class => "clearfix" do
          haml_tag :div, :id => "#{name}-blocks-wrapper", :class => "clearfix" do
            haml_tag :div, :id =>  "#{name}-blocks", :class => "container-twelve" do
              if block_given?
                yield
              else
                bunch_of_blocks.each do |block|
                  haml_concat render(:partial => "blocks/block", :locals => {:block => block})
                end
              end
            end
          end
        end
      end
    end
  end
end

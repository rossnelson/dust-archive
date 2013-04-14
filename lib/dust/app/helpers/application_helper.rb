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
    image_tag("admin/ui/edit-icon.png", :class =>"brush tip", :title => "Edit #{type}")
  end

  def delete_icon(type="")
    image_tag("admin/ui/delete-icon.png", :class =>"brush tip", :title => "Delete #{type}")
  end

  def index_icon(type="")
    image_tag("admin/ui/index-icon.png", :class =>"eye tip", :title => "Show All #{type}")
  end

  def new_icon(type="")
    image_tag("admin/ui/new-icon.png", :class =>"eye tip", :title => "Create New #{type}")
  end

end

module MenuSort
  def self.included(controller)
    controller.send :helper_method, :menu_sort
  end

  def menu_sort(newlist)

    newlist = newlist.to_a

    newlist.each do |array|
      index = array[0].to_i
      array.insert(0, index)
      array.delete_at(1)
    end

    newlist = newlist.sort

    previous = nil
    this_class_data = newlist[0][1][:id].match('(dust)_(.+)_\d+')
    this_class = "#{this_class_data[1].camelize}::#{this_class_data[2].camelize}".constantize

    newlist.each_with_index do |array, index|

      moved_item_id = array[1][:id].scan(/\d+/)


      current_menu_item = this_class.find_by_id(moved_item_id)

      unless previous.nil?
        previous_item = this_class.find_by_id(previous)
        current_menu_item.move_to_right_of(previous_item)
      else
        current_menu_item.move_to_root
      end

      unless array[1][:children].blank?
        childstuff(array[1], current_menu_item)
      end

      previous = moved_item_id
    end

    this_class.rebuild!

  end

  def childstuff(mynode, menu_item)

    childlist = mynode[:children]

    childlist = childlist.to_a

    childlist.each do |array|
      index = array[0].to_i
      array.insert(0, index)
      array.delete_at(1)
    end

    childlist = childlist.sort

    this_class = childlist[0][1][:id].split(/_+\d+/).join.camelize.constantize

    for child in childlist
      child_id = child[1][:id].scan(/\d+/)
      child_cms_menu_item = this_class.find_by_id(child_id)
      child_cms_menu_item.move_to_child_of(menu_item)

      unless child[1][:children].blank?
        childstuff(child[1], child_cms_menu_item)
      end
    end

  end
end

module Dust
  class MenuSort

    attr_accessor :previous, :position, :value, :id, :class, :list

    def initialize(list={}, class_name=nil, parent=nil)
      @class_name = class_name
      @parent = parent
      @previous = nil
      @list = format_list(list.to_a) 
      self.sort_list
    end

    def format_list(list)
      list.map! do |item| 
        Dust::SortableItem.new(:position => item[1]["position"].to_i, 
                               :id => item[1]["id"], 
                               :class_name => @class_name, 
                               :children => item[1]["children"]) 
      end
      list.sort_by! { |item| item.position }
    end

    def sort_list
      @list.each do |item|
        @current_menu_item = item.object_class.find(item.id)
        if @parent.nil?
          self.sort_roots(item)
        else
          @parent = item.object_class.find(@parent)
          self.sort_children(item)
        end
      end
    end

    def sort_roots(item)
      unless @previous.nil?
        previous_item = item.object_class.find_by_id(@previous)
        @current_menu_item.move_to_right_of(previous_item)
      else
        @current_menu_item.move_to_root
      end
      @previous = item.id
    end

    def sort_children(item)
      child_cms_menu_item = item.object_class.find_by_id(item.id)
      child_cms_menu_item.move_to_child_of(@parent)
    end

  end
end

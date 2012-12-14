module Dust
  class SortableItem

    attr_accessor :position
    attr_reader :object_class, :id, :position

    def initialize(options={})
      @position = options[:position]
      @class = options[:class]

      self.id = options[:id]
      self.object_class = options[:id]
      self.children = options[:children]
    end

    def object_class=(id)
      this_class_data = id.match('(dust)_(.+)_\d+')
      @object_class = "#{this_class_data[1].camelize}::#{this_class_data[2].camelize}".constantize
      @object_class
    end

    def id=(id)
      @id = id.match(/\d+/)[0]
      @id
    end

    def children=(children)
      @children = Dust::MenuSort.new(children, self.id)
      @children
    end

  end
end

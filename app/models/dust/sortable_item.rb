module Dust
  class SortableItem

    attr_accessor :position
    attr_reader :object_class, :id, :position

    def initialize(options={})
      @position = options[:position]
      @object_class = options[:class_name].constantize
      @id = options[:id]

      self.children = options[:children]
    end

    def children=(children)
      @children = Dust::Sort.new(children, @object_class, self.id)
      @children
    end

  end
end

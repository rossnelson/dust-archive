module Dust
  module Builder
    class Page

      def initialize(options={})
        @page          = options[:page]
        @sections      = options[:sections] || []
        @page_attrs    = options[:attrs] if options[:attrs]

        @page.sections = []
      end

      def save
        ::Dust::Page.transaction do
          build_sections
          @page.save
        end
      end

      def update
        ::Dust::Page.transaction do
          build_sections
          @page.update_attributes(@page_attrs)
        end
      end

      private

      def build_sections
        @sections.each do |section_attr|
          section = ::Dust::Section.find_or_create_by_title(section_attr[1][:title])

          if section_attr[1]["_destroy"] == "1"
            section.destroy
          else
            section_attr[1].delete("_destroy")
            section.update_attributes(section_attr[1])
            @page.sections << section
          end
        end
      end

    end
  end
end


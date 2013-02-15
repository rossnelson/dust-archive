module Dust
  module Builder
    class Page

      attr_accessor :page, :new_sections, :page_attrs

      def initialize(options={})
        @page          = options[:page]
        @sections      = options[:sections] || []
        @page_attrs    = options[:attrs] if options[:attrs]

        @new_sections = []
      end

      def save
          build_sections
          if @page.errors.blank?
            @page.sections = @new_sections
            @page.save
          else
            false
          end
      end

      def update
          build_sections
          if @page.errors.blank?
            @page.sections = @new_sections
            @page.update_attributes(@page_attrs)
          else
            false
          end
      end

      private

      def build_sections
        @sections.each do |section_attr|
          section = ::Dust::Section.find_or_create_by_title_and_page_id(section_attr[1][:title], @page.id)
          unless section.valid?
            @page.errors[:base] << "Section #{section.title} is not valid"
          end

          if section_attr[1]["_destroy"] == "1"
            section.destroy
          else
            section_attr[1].delete("_destroy")
            section.update_attributes(section_attr[1])
          end
          @new_sections << section
        end
      end

    end
  end
end


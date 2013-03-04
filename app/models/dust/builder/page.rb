module Dust
  module Builder
    class Page

      def initialize(options={})
        @page       = options[:page]
        @sections   = options[:sections] || []
        @page_attrs = options[:attrs] if options[:attrs]
      end

      def save
        build_sections
        if @page.errors.blank?
          @page.save
        else
          false
        end
      end

      def update
        build_sections
        if @page.errors.blank?
          @page.update_attributes(@page_attrs)
        else
          false
        end
      end

      private


      def build_sections
        @sections.each do |section_attr|
          section = ::Dust::Section.find_or_create_by_id_and_page_id(section_attr[0], @page.id)

          if section_attr[1]["_destroy"] == "1"
            section.destroy
          else
            section_attr[1].delete("_destroy")
            section.id = nil if section.new_record?
            section.assign_attributes section_attr[1]

            determine_validity_of(section)
            @page.sections << section
          end
        end
      end

      def determine_validity_of(section)
        unless section.valid?
          @page.errors[:base] << "Section #{section.title} is not valid"
          section.errors.full_messages.each do |error|
            @page.errors[:base] << "Section | #{error}"
          end
        end
      end

    end
  end
end


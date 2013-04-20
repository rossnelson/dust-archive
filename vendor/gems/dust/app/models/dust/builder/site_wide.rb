module Dust
  module Builder
    class SiteWide

      include ActiveModel::Validations

      attr_accessor :variables

      def initialize(options={})
        @options = options[:options]
        @variables = []
      end

      def update
        build_variables
        if self.errors.blank?
          update_variables
        else
          false
        end
      end

      private

      def update_variables
        @variables.each do |var|
          var.save
        end
      end

      def build_variables
        @options.each do |option|
          variable = Dust::SiteWide.find option[0]
          variable.assign_attributes option[1]
          determine_validity_of variable
        end
      end

      def determine_validity_of(variable)
        unless variable.valid?
          variable.errors.full_messages.each do |error|
            self.errors[:base] << "#{variable.category}:#{variable.name} | #{error}"
          end
        end
        @variables << variable
      end

    end
  end
end

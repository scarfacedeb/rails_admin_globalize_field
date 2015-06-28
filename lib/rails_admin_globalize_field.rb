require 'rails_admin_globalize_field/engine'
require 'rails_admin'
require 'rails_admin/config/fields/association'

module RailsAdmin
  module Config
    module Fields
      module Types
        class GlobalizeTabs < RailsAdmin::Config::Fields::Association
          RailsAdmin::Config::Fields::Types::register(:globalize_tabs, self)

          # A workaround for https://github.com/sferik/rails_admin/pull/1726
          def initialize(parent, name, properties)
            properties = parent.abstract_model.associations.detect { |p| name == p.name }
            super
          end

          register_instance_option :partial do
            :form_globalize_tabs
          end

          def method_name
            "#{super}_attributes".to_sym
          end

          def generic_help
            "" # false is ignored by I18n.translate
          end

          # Reader for validation errors of the bound object
          def errors
            bindings[:object].errors[name]
          end

          def available_locales
            I18n.available_locales
          end
          def current_locale
            I18n.locale
          end

          # Returns array of Translation objects.
          # It gets existing or creates new empty translation for every locale.
          # Call the first time with reset_cache == true to update memoized translations.
          def translations reset_cache=false
            return @translations if @translations && !reset_cache

            translations = @bindings[:object].translations_by_locale
            new_locales = available_locales - translations.keys.map(&:to_sym)

            new_locales.map do |locale|
              translations[locale] = @bindings[:object].translations.new({ locale: locale })
            end

            @translations = translations
          end
        end
      end
    end
  end
end
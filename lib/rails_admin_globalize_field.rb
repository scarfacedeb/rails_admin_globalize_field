require "rails_admin_globalize_field/engine"

module RailsAdminGlobalizeField
end

require 'rails_admin/config/fields/association'

module RailsAdmin
  module Config
    module Fields
      module Types
        class GlobalizeTabs < RailsAdmin::Config::Fields::Association
          RailsAdmin::Config::Fields::Types::register(:globalize_tabs, self)

          register_instance_option :partial do
            :form_globalize_tabs
          end

          def method_name
            "#{super}_attributes".to_sym
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

          # Returns array of Translation objects
          # It gets existing or creates new empty translation for every locale
          # It's used in fields_for method in partial
          def translations
            translated_locales = @bindings[:object].translated_locales
            available_locales.collect do |locale|
              translated_locales.include?(locale) ? @bindings[:object].translation_for(locale) : @bindings[:object].translations.new({ locale: locale })
            end
          end
        end
      end
    end
  end
end


# TODO: apply it only on `configure :translations, :globalize_tabs` fields?
# see: https://github.com/sferik/rails_admin/pull/1726
RailsAdmin::Config::Fields.register_factory do |parent, properties, fields|
  if properties[:name] == :translations
    fields << RailsAdmin::Config::Fields::Types::GlobalizeTabs.new(parent, properties[:name], properties)
    true
  else
    false
  end
end
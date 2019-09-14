# frozen_string_literal: true

require 'rails_admin_globalize_field/engine'
require 'rails_admin/config/fields/association'
require 'rails_admin_globalize_field/tab'

module RailsAdmin
  module Config
    module Fields
      module Types
        class GlobalizeTabs < RailsAdmin::Config::Fields::Association
          RailsAdmin::Config::Fields::Types.register(:globalize_tabs, self)

          register_instance_option :partial do
            :form_globalize_tabs
          end

          def method_name
            "#{super}_attributes".to_sym
          end

          def available_locales
            I18n.available_locales
          end

          def tabs
            tabs =
              available_locales.map do |locale|
                RailsAdminGlobalizeField::Tab.new(
                  locale,
                  bindings[:object].translation_for(locale),
                  validate: submit_action?
                )
              end

            activate_tab(tabs)
            tabs
          end

          # Hack to distinguish between REST new/edit and create/update actions.
          # Taken from rails_admin/configs/new.rb
          def submit_action?
            !bindings[:controller].request.get?
          end

          def activate_tab(tabs)
            opened = tabs.find(&:invalid?) || tabs.first
            opened&.active!
          end
        end
      end
    end
  end
end

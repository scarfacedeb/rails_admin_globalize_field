# frozen_string_literal: true

module RailsAdminGlobalizeField
  class Tab
    LABEL_KEY = 'admin.globalize_field.tab_label'

    attr_reader :locale, :translation

    def initialize(locale, translation, validate: true)
      @locale = locale
      @translation = translation
      @validate = validate
    end

    def id
      ['pane', translation.model_name.param_key, translation.id, locale].join('-')
    end

    def label
      if I18n.exists?(LABEL_KEY, locale: locale)
        I18n.t(LABEL_KEY, locale: locale)
      else
        locale
      end
    end

    def active!
      @active = true
    end

    def active?
      @active
    end

    def valid?
      !@validate || translation.valid?
    end

    def invalid?
      !valid?
    end
  end
end

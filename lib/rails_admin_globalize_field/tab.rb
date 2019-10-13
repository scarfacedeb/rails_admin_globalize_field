# frozen_string_literal: true

module RailsAdminGlobalizeField
  class Tab
    attr_reader :locale, :translation

    def initialize(locale, translation, validate: true)
      @locale = locale
      @translation = translation
      @validate = validate
    end

    def id
      ['pane', translation.model_name.param_key, locale].join('-')
    end

    def label
      @locale
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

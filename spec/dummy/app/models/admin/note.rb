module Admin
  def self.table_name_prefix
    'admin_'
  end

  class Note < ActiveRecord::Base
    translates :title
    accepts_nested_attributes_for :translations, allow_destroy: true
  end
end
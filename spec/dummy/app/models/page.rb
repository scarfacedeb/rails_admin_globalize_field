class Page < ActiveRecord::Base
  translates :title, :content
  accepts_nested_attributes_for :translations, allow_destroy: true
end
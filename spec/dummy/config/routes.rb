Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
end

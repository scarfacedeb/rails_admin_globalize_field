RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Dummy', 'Admin']

  # Include specific models (exclude the others):
  config.included_models = ['Page', 'Page::Translation', 'Admin::Note', 'Admin::Note::Translation']

  ################  Actions configuration  ################

  config.actions do
     # root actions
     dashboard                     # mandatory

     # collection actions
     index                         # mandatory
     new
     #export
     #history_index
     #bulk_delete

     # member actions
     show
     edit
     delete
     #history_show
     # show_in_app
   end


  ################  Model configuration  ################

  config.model 'Page' do
    configure :translations, :globalize_tabs do
      active true # open by default
    end

    edit do
      include_fields :translations, :slug, :image
    end
  end

  config.model 'Page::Translation' do
    include_fields :locale, :title, :content
  end

  config.model 'Admin::Note' do
    configure :translations, :globalize_tabs do
      active true # open by default
    end

    edit do
      include_fields :translations, :image
    end
  end

  config.model 'Admin::Note::Translation' do
    field :title do
      label 'Custom note title'
    end
    include_fields :locale, :title
  end


end

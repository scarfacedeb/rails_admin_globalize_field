# RailsAdminGlobalizeField

RailsAdminGlobalizeField adds tabbed interface to [rails_admin](https://github.com/sferik/rails_admin) for multilingual models (using [globalize](https://github.com/globalize/globalize) gem)

It adds custom field type that you can use for globalize's translations association.


## Installation

Add and configure globalize first.

``` ruby
  gem 'globalize', '~> 5.0'
```

Add this gem and run `bundle`.

``` ruby
  gem 'rails_admin_globalize_field', '~> 1.0'
```


## Usage

> Don't forget to set I18n.available_locale, because it uses that to determine what tabs to show

Add **translation** models to `config.included_models` in `initializers/rails_admin.rb`:
``` ruby
  config.included_models = ['Model','Model::Translation']
```

Add `accepts_nested_attributes_for` for translations to your **translated** model.

``` ruby
  class Model < ActiveRecord::Base
    translates :title, :desc
    accepts_nested_attributes_for :translations, allow_destroy: true
  end
```

Add configuration to your **translated** model and associated **translation** model. `:locale` field is always required.
``` ruby
  config.model 'Post' do
    configure :translations, :globalize_tabs
  end

  config.model 'Model::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :desc
  end
```

If you need to add validation to the translation class, you can add it on `translation_class` inside **translated** model:
```ruby
  translation_class.validates :title, presence: true
```

### Customizing the UI

#### Localized labels

If you're localizing the Rails Admin UI, you might want to localize the labels of the tabbed interface.

Say you have this in your app:

![Screenshot](https://raw.githubusercontent.com/felix91gr/rails_admin_globalize_field/screenshots/screenshots/labels_1.png)

And you wish it to look like this when Rails Admin is using the Serbian language:

![Screenshot](https://raw.githubusercontent.com/felix91gr/rails_admin_globalize_field/screenshots/screenshots/labels_0.png)

To do that, you need to add these keys to your localization files:

```yaml
sr:
  activerecord:
    attributes:
      initiative:
        # ...
        translations: Prevodi
      initiative/translation:
        description: Opis
        summary: Summari
        title: Naslov
```

Everything inside the tabbed interface goes by `<model_name>/translation.<field_name>`. And the "Translations" label goes by `<model_name>.translations`.

#### Custom Tab names

You might want to change the UI so that the tabs spell the names of the locales, like this:

![Screenshot](https://raw.githubusercontent.com/felix91gr/rails_admin_globalize_field/screenshots/screenshots/tabs_0.png)

To do that, you'll need to override the way the gem labels its tabs. To do that, go through these steps:

1. Create a new initializer in your Rails project with an apt name (`config/initializers/rails_admin_globalize_fields.rb`, for example).
2. In that initializer, override the class method `label`.
3. Restart the app to see the changes applied.

##### For one locale

If you wanted to have the same name for all locales, say, if your Rails Admin interface is only localized to English, then you'd do it like this:

* In your initializer:

```ruby
RailsAdminGlobalizeField::Tab.class_eval do
    def label
        I18n.translate("locale_name", locale: locale)
    end
end
```

* In your locale file(s):

```yaml
en:
  locale_name: "English"
sq:
  locale_name: "Albanian"
sr:
  locale_name: "Serbian"
```

##### For multiple locales

If instead you are localizing the Rails Admin interface, you would want the locale names to be available in all different languages. One way you could do that is like this:

* In your initializer:

```ruby
RailsAdminGlobalizeField::Tab.class_eval do
    def label
        I18n.translate("locale_name.#{locale}")
    end
end
```

* In your locale file(s):

```yaml
en:
  locale_name:
    en: English
    sq: Albanian
    sr: Serbian
sq:
  locale_name:
    en: anglisht
    sq: shqiptar
    sr: serb
sr:
  locale_name:
    en: Engleski
    sq: Albanski
    sr: Srpski
```

## Screenshot

![Screenshot](https://raw.github.com/scarfaceDeb/rails_admin_globalize_field/screenshots/screenshots/shot1.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

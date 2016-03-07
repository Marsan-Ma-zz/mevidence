source 'https://rubygems.org'
ruby '2.1.2'

#=========================================
#   Web Main
#=========================================
gem 'rails', '4.1.7'
gem "mongoid"

gem 'sass-rails', '~> 4.0.3'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# gem 'sqlite3'
gem "therubyracer", :group => :assets, :platform => :ruby, :require => "v8"
gem "settingslogic"

#=========================================
#   Frontend
#=========================================
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'high_voltage'
gem 'simple_form'
gem 'nested_form'
gem 'kaminari-bootstrap'
gem "combined_time_select"
gem 'font-awesome-sass'
#gem 'fullcalendar-rails'
# gem "simple_calendar"
gem 'mobvious'

# parser
gem "creek"

# SEO
gem 'sitemap_generator'
gem 'meta-tags', :require => 'meta_tags'
gem 'canonical-rails'
gem 'roboto'

# i18n
gem 'chinese_pinyin'  # translate chinese to pinyin, for slug_sanitize

# cronjobs
gem 'whenever', :require => false

#=========================================
#   Development
#=========================================
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'puma'
end

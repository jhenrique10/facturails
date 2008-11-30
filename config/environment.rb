# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = { :session_key => "_facturails", :secret => "08645eb7f32a453e4ea009622195bc6b" }
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  config.frameworks -= [ :action_web_service, :action_mailer ]

end

require 'accumulator'

#Date::MONTHNAMES = %w(
#  Enero Febrero Marzo Abril Mayo Junio Julio Agosto
#  Septiembre Octubre Noviembre Diciembre
#)

I18n.default_locale = 'es-ES'

date_formats = {
  :date => '%d/%m/%Y'
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_formats)

Mime::Type.register "application/pdf", :pdf

# config vars
TMP_DIR = File.expand_path(File.join(RAILS_ROOT, "tmp"))

JAVA_OPTIONS = {
  :bin => "java", 
  :cp_separator => ":"                                       
}

RESULTS_PER_PAGE = 12

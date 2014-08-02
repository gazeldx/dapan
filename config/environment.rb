# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

DECLINE = 1
ADVANCE = 2
FLAT = 3
FLAT_MAX = 0.35
DEFAULT_NICKNAME = I18n.t('default_nickname')
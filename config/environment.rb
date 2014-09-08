# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

DECLINE = 1
ADVANCE = 2
FLAT = 3
FLAT_MAX = 0.0035

ADF = ['', I18n.t('decline'), I18n.t('advance'), I18n.t('flat')]
AD = {advance: I18n.t('_advance'), decline: I18n.t('_decline')}
DEFAULT_NICKNAME = I18n.t('default_nickname')
HOLIDAYS = ['2014-09-08', '2014-10-01', '2014-10-02', '2014-10-03', '2014-10-06', '2014-10-07']
COLOR = ['', 'success', 'danger', 'warning']
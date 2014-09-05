TODO:
Domain and only id for user homepage.

Asset Pipline not used now.

rails generate migration AddVoteCountsToUsers all_kill:integer month_correct:integer

Cron jobs:
5 15 * * * /bin/bash -l -c 'cd /root/duokong && RAILS_ENV=production bin/rails runner '\''Index.auto_generate'\'' >> log/cron_job.log 2>&1'

Report bug:
RAILS_ENV=production rails console
is Different from 
rails console -e produciton











http://www.jiawei.com/cn/ sina API show a stock preview.
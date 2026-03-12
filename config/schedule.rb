# frozen_string_literal: true

set :environment, 'production'

every 2.hours do
  rake 'crawler'
  # rake 'update_stats' not longer available external URL Facebook API
  rake 'update_api'
  rake 'update_site_stats'
  rake 'ai:set_topic_polarity'
end

every 4.hours do
  rake 'proxy_crawler'
end

every 6.hours do
  rake 'crawler_deep'
  rake 'tagger'
  rake 'ai:generate_ai_reports'
  rake 'facebook:update_fanpages'
end

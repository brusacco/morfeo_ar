# frozen_string_literal: true

set :environment, 'production'

every :hour do
  rake 'crawler'
  rake 'update_stats'
  rake 'update_site_stats'
  rake 'ai:set_topic_polarity'
end

every 3.hours do
  rake 'crawler_deep'
end

every 6.hours do
  rake 'ai:generate_ai_reports'
end

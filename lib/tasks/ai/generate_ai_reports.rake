# frozen_string_literal: true

namespace :ai do
  desc 'Generate AI Reports'
  task generate_ai_reports: :environment do
    Topic.all.each do |topic|
      tag_list = topic.tags.map(&:name)
      analytics = Entry.a_day_ago.tagged_with(tag_list, any: true).order(total_count: :desc).limit(20)
      sleep(5)
      report = analytics.generate_report(topic.name)
      next if report.blank?

      topic.reports.create!(report_text: report)
    end
  end
end

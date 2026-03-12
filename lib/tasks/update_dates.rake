# frozen_string_literal: true

desc 'Update dates'
task update_dates: :environment do
  # Parallel.each(Entry.where(published_at: nil), in_threads: 3) do |entry|
  Parallel.each(Entry.where(site_id: 29), in_threads: 3) do |entry|
    doc = Nokogiri::HTML(URI.parse(entry.url).open)
    result = WebExtractorServices::ExtractDate.call(doc)
    if result.success?
      entry.update!(result.data)
      puts "#{entry.url}: #{result.data}"
    else
      puts "#{entry.url}: #{result.error}"
    end
  rescue StandardError => e
    puts "#{entry.url}: #{e}"
    if e.message.include?('404')
      entry.destroy!
      puts "Entry #{entry.url} deleted due to 404 error."
    end
  end
end

#!/usr/bin/env ruby
# check path duplicates

uniq_entries = []
ENV['PATH'].split(/:/).each do |entry|
  unless uniq_entries.include?(entry)
    uniq_entries << entry
  else
    puts ">>> Duplicate: [#{entry}]"
  end
end

#!/usr/bin/env ruby

# Complete capistrano tasks script for bash
# Save it somewhere and then add
# complete -C path/to/script -o default cap
# to your ~/.bashrc
# Nicholas Seckar <nseckar@gmail.com>
 
exit 0 unless File.file?(File.join(Dir.pwd, 'Capfile'))
exit 0 unless /^cap(?:\s+([-\w]+))?\s*$/ =~ ENV["COMP_LINE"]
 
task_prefix = $1

lines = ""
stop = false
`cap --tasks`.each do |task|
  break if stop  
  stop = true if task =~ /^$/
  lines << task unless task =~ /^$/
end
tasks = lines.split("\n")[1..-1].collect {|line| break if line =~ /^$/; line.split[1]}
tasks = tasks.select {|t| /^#{Regexp.escape task_prefix}/ =~ t} if task_prefix
puts tasks
exit 0

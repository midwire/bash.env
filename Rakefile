require 'rubygems'
require 'rake'
require 'readline'
PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

desc "Write changes to the CHANGELOG"
task :changes do
  text = ask("CHANGELOG Entry:")
  text.insert(0, "*#{read_version.join('.')}* (#{Time.now.strftime("%B %d, %Y")})\n\n")
  text << "\n"
  prepend_changelog(text)
  system("mate CHANGELOG")
end

desc "Increment the patch version and write changes to the changelog"
task :bump_patch do
  major, minor, patch = read_version
  patch = patch.to_i + 1
  write_version([major, minor, patch])
  version = open('VERSION').read.chomp
  readme = open('README.markdown').read
  File.open('README.markdown', 'w') {|f| f.write(readme.gsub(/^\*\*Version: [0-9\.]+\*\*$/, "**Version: #{version}**")) }
  Rake::Task["changes"].invoke
end
desc "Alias for :bump_patch"
task :bump => :bump_patch do; end

desc "Increment the minor version and write changes to the changelog"
task :bump_minor do
  major, minor, patch = read_version
  minor = minor.to_i + 1
  patch = 0
  write_version([major, minor, patch])
  Rake::Task["changes"].invoke
end

desc "Increment the major version and write changes to the changelog"
task :bump_major do
  major, minor, patch = read_version
  major = major.to_i + 1
  minor = 0
  patch = 0
  write_version([major, minor, patch])
  Rake::Task["changes"].invoke
end

desc "Open the github site in your browser"
task :github do
  system("open https://github.com/midwire/.env")
end
desc "Alias for :github task"
task :home => [:github] do; end

##################################################
private

  def read_version
    text = File.readlines("#{PROJECT_ROOT}/VERSION").to_s.chomp
    major, minor, patch = text.split('.')
  end

  def write_version(version_array)
    version = version_array.join('.')
    File.open("#{PROJECT_ROOT}/VERSION", 'w') {|f| f.write(version) }
  end

  def prepend_changelog(text_array)
    # read current changelog
    old = File.readlines("#{PROJECT_ROOT}/CHANGELOG").to_s.chomp
    text_array.push(old)
    File.open("#{PROJECT_ROOT}/CHANGELOG", 'w')  do |f| 
      text_array.each do |line|
        f.puts(line)
      end
    end
  end

  def ask(message)
    response = []
    puts message
    puts "Hit <Control>-D when finished:"
    while line = Readline.readline('* ', false)
      response << "* #{line.chomp}" unless line.nil?
    end
    response
  end

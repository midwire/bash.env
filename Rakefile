require 'rubygems'
require 'rake'
require 'readline'
require 'pry' if ENV['TEST']
PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))

desc "Write changes to the CHANGELOG"
task :changes do
  text = ask("CHANGELOG Entry:")
  text.insert(0, "*#{read_version.join('.')}* (#{Time.now.strftime("%B %d, %Y")})\n\n")
  text << "\n"
  prepend_changelog(text)
  system("#{ENV['EDITOR']} CHANGELOG")
end

desc "Increment the patch version and write changes to the changelog"
task :bump_patch do
  major, minor, patch = read_version
  patch = patch.to_i + 1
  write_version([major, minor, patch])
  version = open('VERSION').read.chomp
  readme = open('README.md').read
  File.open('README.md', 'w') {|f| f.write(readme.gsub(/^\*\*Version: [0-9\.]+\*\*$/, "**Version: #{version}**")) }
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

desc "Create a GitHub release for the current version"
task :release do
  version = read_version.join('.')
  tag = "v#{version}"

  # Ensure we're on a clean working tree
  unless system("git diff --quiet HEAD")
    abort "ERROR: Working tree is dirty. Commit or stash changes before releasing."
  end

  # Create and push the tag if it doesn't exist
  if system("git rev-parse #{tag} >/dev/null 2>&1")
    puts "Tag #{tag} already exists."
  else
    system("git tag -a #{tag} -m 'Release #{tag}'") || abort("Failed to create tag")
    system("git push origin #{tag}") || abort("Failed to push tag")
  end

  # Extract the latest changelog entry for release notes
  changelog = File.read("#{PROJECT_ROOT}/CHANGELOG").to_s
  # Grab everything from the current version header to the next version header
  notes = changelog[/^\*#{Regexp.escape(version)}\*.*?(?=^\*\d+\.\d+\.\d+\*|\z)/m].to_s.strip

  # Create the GitHub release
  if notes.empty?
    system("gh release create #{tag} --title '#{tag}' --generate-notes") || abort("Failed to create release")
  else
    IO.popen(["gh", "release", "create", tag, "--title", tag, "--notes-file", "-"], "w") do |io|
      io.write(notes)
    end
    abort("Failed to create release") unless $?.success?
  end

  puts "Released #{tag} on GitHub."
end

desc "Run ShellCheck on all shell scripts"
task :lint do
  files = Dir.glob("#{PROJECT_ROOT}/**/*.sh") + Dir.glob("#{PROJECT_ROOT}/**/*.plugin.sh")
  files.reject! { |f| f.include?('/custom/') }
  if system("command -v shellcheck >/dev/null 2>&1")
    files.each do |f|
      system("shellcheck -e SC1090,SC1091,SC2034,SC2154 -S warning #{f}")
    end
  else
    abort "shellcheck not found. Install it: https://github.com/koalaman/shellcheck#installing"
  end
end

desc "Run Bats test suite"
task :test do
  if system("command -v bats >/dev/null 2>&1")
    system("bats #{PROJECT_ROOT}/test/") || abort("Tests failed")
  else
    abort "bats not found. Install it: https://github.com/bats-core/bats-core#installation"
  end
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
    text = File.read("#{PROJECT_ROOT}/VERSION").to_s.chomp
    major, minor, patch = text.split('.')
  end

  def write_version(version_array)
    version = version_array.join('.')
    File.open("#{PROJECT_ROOT}/VERSION", 'w') {|f| f.write(version.to_s) }
  end

  def prepend_changelog(text_array)
    # read current changelog
    old = File.read("#{PROJECT_ROOT}/CHANGELOG").to_s.chomp
    text_array.push(old)
    File.open("#{PROJECT_ROOT}/CHANGELOG", 'w')  do |f|
      text_array.flatten.each do |line|
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

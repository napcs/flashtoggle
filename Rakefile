require 'rake'
require 'rake/testtask' 
require 'rake/rdoctask' 
require 'lib/flashtoggle/version'

desc "Build the gem"
task :build do
  puts "Building the gem"
  `gem build flashtoggle.gemspec`
end

desc "build and install as a gem"
task :install => :build do
  puts "Installing..."
  `gem install flashtoggle-#{Flashtoggle::VERSION}.gem`
end

desc "release gem to RubyGems.org"
task :release => :build do
  system "gem push flashtoggle-#{Flashtoggle::VERSION}.gem"
end


Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

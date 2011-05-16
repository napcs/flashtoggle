require 'lib/flashtoggle/version.rb'

Gem::Specification.new do |s|
  s.name = "flashtoggle"
  s.version = Flashtoggle::VERSION
  s.summary = "Enable and disable Flash in OSX"
  s.email = "info@napcs.com"
  s.description = "Commandline tool to enable and disable the Flash player in Safari and other applications that use Safari. This conserves battery life and, unlike Flash blocking solutions, this causes web sites to serve alternative content since Flash is truly not available."
  s.homepage    = "http://github.com/napcs/flashtoggle"
  
  s.authors = ["Brian Hogan"]
  s.date = "2011-05-16"
  
  s.files = ["bin/flashtoggle",
            'lib/flashtoggle/version.rb',
            "lib/flashtoggle.rb",
            "lib/flashtoggle/toggler.rb"
  ]
  s.platform    = Gem::Platform::RUBY
  s.executables = ["flashtoggle"]
  s.require_paths = ["lib"]
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "mocha"

end


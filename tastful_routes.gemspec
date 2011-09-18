# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tasteful_routes/version"

Gem::Specification.new do |s|
  s.name              = "tasteful_routes"
  s.version           = TastefulRoutes::VERSION
  s.authors           = ["Icelab", "Hugh Evans"]
  s.email             = "hugh@artpop.com.au"
  s.homepage          = "http://github.com/icelab/tasteful-routes"
  s.summary           = %q{An opinionated variation of the standard Rails
                        RESTful routes that has singular member action URLs.}
  s.description       = %q{An opinionated variation of the standard Rails
                        RESTful routes that has singular member action URLs.}

  s.rubyforge_project = "tasteful_routes"

  s.files             = `git ls-files`.split("\n")
  s.require_path      = "lib"

  s.add_dependency "rails" # leave it to the user to make sure that it is compatible with their version
  s.add_development_dependency "rspec", "~> 2.6.0"
end

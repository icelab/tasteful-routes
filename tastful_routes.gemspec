# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tasteful_routes/version"

Gem::Specification.new do |s|
  s.name              = "tasteful_routes"
  s.version           = TastefulRoutes::VERSION
  s.authors           = ["Icelab", "Hugh Evans"]
  s.email             = "hugh@icelab.com.au"
  s.homepage          = "http://github.com/icelab/tasteful_routes"
  s.summary           = %q{A alternative to Rails' RESTful routes that changes
                        that resolves member actions to singular URLs.}
  s.description       = %q{An alternative to Rails' default RESTful routes that
                        resolves member actions to singular URLs, eg. /job/1 
                        instead of /jobs/1. The collection methods continue to
                        operate on the plural /jobs (index and create).}

  s.rubyforge_project = "tasteful_routes"

  s.files             = `git ls-files`.split("\n")
  s.require_path      = "lib"

  s.add_dependency "rails", "~> 3.0.0"

  s.add_development_dependency "rspec", "~> 2.6.0"
end

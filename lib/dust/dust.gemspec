$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dust/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dust"
  s.version     = Dust::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Dust."
  s.description = "TODO: Description of Dust."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

end

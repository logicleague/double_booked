$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "accountable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "accountable"
  s.version     = Accountable::VERSION
  s.authors     = ["Jay McAliley"]
  s.email       = ["jay.mcaliley@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "lib/generators/**/*"] +
            ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3"

  s.add_development_dependency "sqlite3"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "double_booked/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "double_booked"
  s.version     = DoubleBooked::VERSION
  s.authors     = ["Jay McAliley", "John McAliley", "Jim Van Fleet"]
  s.email       = ["jay@logicleague.com"]
  s.homepage    = ""
  s.summary     = "Flexible double-entry accounting engine for Rails apps"
  s.description = "Double-entry accounting issues credits and debits, calculates balances, allows for summary accounts and more."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "sqlite3"
end

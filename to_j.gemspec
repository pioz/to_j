$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "to_j/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "to_j"
  s.version     = ToJ::VERSION
  s.authors     = ["pioz"]
  s.email       = ["epilotto@gmx.com"]
  s.homepage    = "https://github.com/pioz/to_j"
  s.summary     = "Fast JSON serializer for Rails based on Jbuilder and concept of view"
  s.description = "Fast JSON serializer for Rails based on Jbuilder and concept of view"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "oj"
  s.add_development_dependency "jbuilder"
  s.add_development_dependency "active_model_serializers"
end

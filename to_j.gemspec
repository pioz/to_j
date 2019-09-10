$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'to_j/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'to_j'
  spec.version     = ToJ::VERSION
  spec.authors     = ['Enrico']
  spec.email       = ['epilotto@gmx.com']
  spec.homepage    = 'https://github.com/pioz/to_j'
  spec.summary     = 'Fast JSON serializer for Rails based on Jbuilder and concept of views.'
  spec.description = 'Fast JSON serializer for Rails based on Jbuilder and concept of views.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '>= 5.2'

  spec.add_development_dependency 'active_model_serializers'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'jbuilder'
  spec.add_development_dependency 'oj'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'sqlite3'
end

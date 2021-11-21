require_relative 'lib/factory_bot/refinements/version'

Gem::Specification.new do |spec|
  spec.name                  = 'factory_bot-refinements'
  spec.version               = FactoryBot::Refinements::VERSION
  spec.authors               = ['Keita Urashima', 'Ryunosuke Sato']
  spec.email                 = ['ursm@ursm.jp']
  spec.summary               = 'Extensions for factory_bot'
  spec.homepage              = 'https://github.com/ursm/factory_bot-refinements'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.7'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = "#{spec.homepage}.git"
  spec.metadata['changelog_uri']   = "#{spec.homepage}/releases"

  spec.files = Dir[
    'README.md',
    'LICENSE.txt',
    'lib/**/*.rb'
  ]

  spec.require_paths = ['lib']

  spec.add_dependency 'factory_bot'
end

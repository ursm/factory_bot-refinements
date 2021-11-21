require 'factory_bot'
require 'rspec/core'

module FactoryBot
  module Refinements
    module RSpec
      def self.normalize_name_and_factory(name_and_factory)
        case name_and_factory
        when Array
          name_and_factory
        else
          [name_and_factory, name_and_factory]
        end
      end

      refine Symbol do
        def as(as)
          [as, self]
        end
      end

      refine ::RSpec::Core::ExampleGroup.singleton_class do
        def create(name_and_factory, ...)
          name, factory = RSpec.normalize_name_and_factory(name_and_factory)

          let!(name) { FactoryBot.create(factory, ...) }
        end

        def create_lazy(name_and_factory, ...)
          name, factory = RSpec.normalize_name_and_factory(name_and_factory)

          let(name) { FactoryBot.create(factory, ...) }
        end

        def build(name_and_factory, ...)
          name, factory = RSpec.normalize_name_and_factory(name_and_factory)

          let!(name) { FactoryBot.build(factory, ...) }
        end

        def build_lazy(name_and_factory, ...)
          name, factory = RSpec.normalize_name_and_factory(name_and_factory)

          let(name) { FactoryBot.build(factory, ...) }
        end
      end
    end
  end
end

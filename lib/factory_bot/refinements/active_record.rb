require 'active_record'
require 'factory_bot'

module FactoryBot
  module Refinements
    module ActiveRecord
      def self.default_factory(association)
        association.klass.model_name.singular
      end

      refine ::ActiveRecord::Associations::CollectionProxy do
        def factory(name)
          tap { @__factory = name }
        end

        def create_with_factory(*args, **kwargs, &block)
          factory = @__factory || ActiveRecord.default_factory(proxy_association)
          key     = proxy_association.reflection.inverse_of.name

          FactoryBot.create(factory, *args, key => proxy_association.owner, **kwargs, &block).tap {
            @__factory = nil
          }
        end

        def build_with_factory(...)
          factory = @__factory || ActiveRecord.default_factory(proxy_association)

          FactoryBot.build(factory, ...).tap {|record|
            proxy_association.add_to_target record

            @__factory = nil
          }
        end
      end
    end
  end
end

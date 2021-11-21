require_relative 'refinements/version'

module FactoryBot
  module Refinements
    begin
      require 'active_record'
    rescue LoadError
      # optional
    else
      require_relative 'refinements/active_record'

      include ActiveRecord
    end

    begin
      require 'rspec/core'
    rescue LoadError
      # optional
    else
      require_relative 'refinements/rspec'

      include RSpec
    end
  end
end

require 'active_record'
require 'factory_bot'
require 'sqlite3'

require 'factory_bot-refinements'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.call

      raise ActiveRecord::Rollback
    end
  end
end

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  create_table :users, force: :cascade do |t|
    t.string :name
  end

  create_table :posts, force: :cascade do |t|
    t.references :author, to_table: :users
    t.string :title
    t.boolean :published
  end
end

class User < ActiveRecord::Base
  has_many :posts, inverse_of: :author, foreign_key: 'author_id'
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
end

FactoryBot.define do
  factory :user

  factory :post do
    published { false }

    factory :published_post do
      published { true }
    end
  end
end

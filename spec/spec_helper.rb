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

ActiveRecord::Schema.define do
  create_table :users, force: :cascade do |t|
    t.string :name
  end

  create_table :articles, force: :cascade do |t|
    t.references :author, to_table: :users
    t.string :title
    t.boolean :featured
  end

  create_table :comments, force: :cascade do |t|
    t.references :article
  end
end

class User < ActiveRecord::Base
  has_many :articles, inverse_of: :author, foreign_key: 'author_id'
end

class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :article
end

FactoryBot.define do
  factory :user

  factory :article do
    featured { false }

    factory :featured_article do
      featured { true }
    end
  end

  factory :comment
end

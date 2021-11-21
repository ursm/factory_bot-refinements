# FactoryBot::Refinements

Extensions for factory_bot

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_bot-refinements'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install factory_bot-refinements

## Usage

Add the following code to your test file:

``` ruby
# ActiveRecord extensions
using FactoryBot::Refinements::ActiveRecord

# RSpec extensions
using FactoryBot::Refinements::RSpec

# Or both of them
using FactoryBot::Refinements
```

### FactoryBot::Refinements::ActiveRecord

Add a set of methods to create/build a record using a factory for `has_many` associations. All arguments, including keyword arguments and a block, will be delegated to the factory.

By default, the factory to use will be automatically looked up from the association's class. You can also specify an arbitrary one with `factory()`.


``` ruby
using FactoryBot::Refinements::ActiveRecord

describe MyApp do
  example do
    user = create(:user)

    user.posts.create_with_factory(:published, title: 'hello')
    # Equivalent to:
    # FactoryBot.create(:post, :published, user: user, title: 'hello')

    user.posts.factory(:featured_post).create_with_factory
    # Equivalent to:
    # FactoryBot.create(:featured_post, user: user)

    user.posts.build_with_factory
    # Equivalent to:
    # FactoryBot.build(:post, user: user)
  end
end
```

### FactoryBot::Refinements::RSpec

Add a set of short-hand methods to the describe/context block that do `FactoryBot.create/build` and `let/let!` together. All arguments except the first, including keyword arguments and a block, will be delegated to the factory as-is.

``` ruby
using FactoryBot::Refinements::RSpec

describe MyApp do
  create :user, name: 'alice'
  # Equivalent to:
  # let!(:user) { FactoryBot.create(:user, name: 'alice') }

  create :user.as(:bob), :admin, name: 'bob'
  # Equivalent to:
  # let!(:bob) { FactoryBot.create(:user, :admin, name: 'bob') }

  create_lazy :user
  # Equivalent to (let, not let!):
  # let(:user) { FactoryBot.create(:user) }

  build :user
  # Equivalent to:
  # let!(:user) { FactoryBot.build(:user) }

  build_lazy :user
  # Equivalent to:
  # let(:user) { FactoryBot.build(:user) }
end
```

#### Limitations

Due to scope constraints, these factories do not have access to other `let` values. Therefore, it is recommended to use them for fixture-like fixed data setups. If you need `let` to build associations, consider using [RSpec::LetAs](https://github.com/ursm/rspec-let_as).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

using FactoryBot::Refinements

RSpec.describe FactoryBot::Refinements do
  create(:user, name: 'ursm') {|user|
    user.articles.create_with_factory(title: 'hi')
  }

  example do
    expect(user.name).to                  eq('ursm')
    expect(user.articles.size).to         eq(1)
    expect(user.articles.first.title).to  eq('hi')
    expect(user.articles.first.author).to eq(user)
  end
end

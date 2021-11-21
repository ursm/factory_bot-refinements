using FactoryBot::Refinements

RSpec.describe FactoryBot::Refinements do
  create(:user, name: 'ursm') {|user|
    user.posts.create_with_factory(title: 'hi')
  }

  example do
    expect(user.name).to eq('ursm')

    expect(user.posts).to contain_exactly(
      have_attributes(
        title:  'hi',
        author: user,
      )
    )
  end
end

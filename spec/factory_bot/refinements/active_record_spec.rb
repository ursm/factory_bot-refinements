using FactoryBot::Refinements::ActiveRecord

RSpec.describe FactoryBot::Refinements::ActiveRecord do
  example 'create/build association with a factory' do
    user = FactoryBot.create(:user)

    post_1 = user.posts.create_with_factory(title: 'hello')
    post_2 = user.posts.build_with_factory(title: 'bye')

    expect(user.posts).to contain_exactly(
      have_attributes(
        title:      'hello',
        author:     user,
        persisted?: true,
      ),

      have_attributes(
        title:      'bye',
        author:     user,
        persisted?: false,
      )
    )
  end

  example 'creating a child record affects the persistence of the parent record' do
    user = FactoryBot.build(:user)

    expect(user).not_to be_persisted

    expect {
      user.posts.build_with_factory
    }.not_to change { user.persisted? }.from(false)

    expect {
      user.posts.create_with_factory
    }.to change { user.persisted? }.from(false).to(true)
  end

  example 'specify a factory' do
    user = FactoryBot.create(:user)

    post_1 = user.posts.build_with_factory
    post_2 = user.posts.factory(:published_post).build_with_factory
    post_3 = user.posts.build_with_factory

    expect(post_1).not_to be_published
    expect(post_2).to be_published
    expect(post_3).not_to be_published
  end
end

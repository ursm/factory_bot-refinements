using FactoryBot::Refinements::ActiveRecord

RSpec.describe FactoryBot::Refinements::ActiveRecord do
  example 'create/build association with a factory' do
    user = FactoryBot.create(:user)

    article_1 = user.articles.create_with_factory(title: 'hello')
    article_2 = user.articles.build_with_factory(title: 'bye')

    expect(user.articles.size).to eq(2)

    expect(article_1).to be_persisted
    expect(article_1.title).to eq('hello')
    expect(article_1.author).to eq(user)

    comment_1 = article_1.comments.build_with_factory
    comment_2 = article_1.comments.create_with_factory

    expect(comment_1).not_to be_persisted
    expect(comment_2).to be_persisted

    expect(article_2).not_to be_persisted
    expect(article_2.title).to eq('bye')
    expect(article_2.author).to eq(user)

    comment_3 = article_2.comments.build_with_factory

    expect(comment_3).not_to be_persisted
    expect(article_2).not_to be_persisted

    comment_4 = article_2.comments.create_with_factory

    expect(comment_4).to be_persisted
    expect(article_2).to be_persisted
  end

  example 'specify a factory' do
    user = FactoryBot.create(:user)

    article_1 = user.articles.build_with_factory
    article_2 = user.articles.factory(:featured_article).build_with_factory
    article_3 = user.articles.build_with_factory

    expect(article_1).not_to be_featured
    expect(article_2).to be_featured
    expect(article_3).not_to be_featured
  end
end

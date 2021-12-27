require 'rails_helper'

RSpec.describe ArticlesLaunch, type: :model do

  article = Article.create(title: 'title')
  launch = Launch.create(origin_id: Faker::Internet.uuid, provider: 'teste')

  let(:valid_attributes) {
    {
      article: article,
      launch: launch,
    }
  }

  let(:invalid_attributes) {
    {
      article: nil,
      launch: launch
    }
  }

  it "should launch instance is valid" do
    article_launch = ArticlesLaunch.new(valid_attributes)
    expect(article_launch).to be_valid
  end

  it "should launch instance is invalid" do
    articlesLaunch = ArticlesLaunch.new(invalid_attributes)
    articlesLaunch.valid?
    expect(articlesLaunch).to be_invalid 
  end

end

require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do

  let(:valid_attributes) {
    {
      featured: Faker::Boolean.boolean,
      title: Faker::ChuckNorris.fact,
      url: Faker::Internet.url,
      imageUrl: Faker::Avatar.image,
      newsSite: Faker::Internet.url,
      summary: Faker::Lorem.paragraph,
      publishedAt: Faker::Date.between(from: 2.year.ago, to: Date.today)
    }
  }

  let(:invalid_attributes) {
    {
      featured: Faker::Boolean.boolean,
      title: nil,
      url: Faker::Internet.url,
      imageUrl: Faker::Avatar.image,
      newsSite: Faker::Internet.url,
      summary: Faker::Lorem.paragraph,
      publishedAt: Faker::Date.between(from: 2.year.ago, to: Date.today)
    }
  }

  it "should article instance is valid" do
    article = Article.new(valid_attributes)
    expect(article).to be_valid
  end

  it "should article instance is invalid" do
    article = Article.new(title: nil)
    article.featured = Faker::Boolean.boolean
    article.url = Faker::Internet.url 
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

end

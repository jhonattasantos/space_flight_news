require 'rails_helper'

RSpec.describe ArticlesEvent, type: :model do

  article = Article.create(title: 'title')
  event = Event.create(origin_id: Faker::Internet.uuid, provider: 'teste')

  let(:valid_attributes) {
    {
      article: article,
      event: event,
    }
  }

  let(:invalid_attributes) {
    {
      article: nil,
      event: event
    }
  }

  it "should event instance is valid" do
    article_event = ArticlesEvent.new(valid_attributes)
    expect(article_event).to be_valid
  end

  it "should event instance is invalid" do
    articlesEvent = ArticlesEvent.new(invalid_attributes)
    articlesEvent.valid?
    expect(articlesEvent).to be_invalid 
  end

end

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:valid_attributes) {
    {
      origin_id: Faker::Internet.uuid,
      provider: Faker::University.name,
    }
  }

  let(:invalid_attributes) {
    {
      origin_id: nil,
      provider: Faker::University.name
    }
  }

  it "should event instance is valid" do
    event = Event.new(valid_attributes)
    expect(event).to be_valid
  end

  it "should event instance is invalid" do
    event = Event.new(invalid_attributes)
    event.valid?
    expect(event).to be_invalid
  end

end

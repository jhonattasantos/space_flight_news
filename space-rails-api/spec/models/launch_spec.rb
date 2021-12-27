require 'rails_helper'

RSpec.describe Launch, type: :model do
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

  it "should launch instance is valid" do
    launch = Launch.new(valid_attributes)
    expect(launch).to be_valid
  end

  it "should launch instance is invalid" do
    launch = Launch.new(invalid_attributes)
    launch.valid?
    expect(launch).to be_invalid
  end

end

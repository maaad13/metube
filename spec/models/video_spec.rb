require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:user) { create(:user) }

  subject do
    video = Video.new(title: "test title", description: "test description", user: user)
    video.file.attach(
      io: File.open(Rails.root.join('spec/fixtures/files/test.mp4')),
      filename: 'test.mp4',
      content_type: 'video/mp4'
    )
    video
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end

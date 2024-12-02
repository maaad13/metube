FactoryBot.define do
  factory :video do
    title { "test title" }
    description { "This is a test description." }
    association :user, factory: :user

    after(:build) do |video|
      video.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test.mp4')),
        filename: 'test.mp4',
        content_type: 'video/mp4'
      )
    end
  end
end

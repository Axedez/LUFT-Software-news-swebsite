FactoryBot.define do
  factory :article do
    title { Faker::TvShows::Buffy.character }
    short_description { Faker::TvShows::Buffy.quote }
    long_description { Faker::Lorem.paragraph_by_chars }
    is_visible { [true, false].sample }
    is_private { [true, false].sample }
    user

    trait :with_image do
      image { File.open("#{Rails.root}/app/assets/images/test.png") }
    end
  end
end

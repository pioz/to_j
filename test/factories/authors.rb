FactoryBot.define do
  factory :author do
    name { Faker::Name.first_name }

    transient do
      book_titles { [] }
    end

    after(:build) do |author, evaluator|
      evaluator.book_titles.each do |book_title|
        author.books << build(:book, title: book_title)
      end
    end
  end
end

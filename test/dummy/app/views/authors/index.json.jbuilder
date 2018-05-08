json.array! @authors do |author|
  json.(author, :id, :name)
  json.books do
    json.array! author.books, partial: 'book', as: :book
  end
end
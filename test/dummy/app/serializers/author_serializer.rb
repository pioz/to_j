module AuthorSerializer

  def default(obj, options)
    self.extract!(obj, :id, :name)
  end

  def with_books(obj, options)
    default(obj, options)
    self.books do
      self.array!(obj.books.map{|book| book.to_j(options)})
    end
  end

end
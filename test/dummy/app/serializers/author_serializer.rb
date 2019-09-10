module AuthorSerializer
  def default(obj, _options)
    self.extract!(obj, :id, :name)
  end

  def with_books(obj, options)
    default(obj, options)
    self.books do
      self.array!(obj.books.map { |book| book.to_j(options) })
    end
  end

  def all_fields(obj, _options)
    self.merge!(obj.attributes)
  end
end

module BookSerializer
  def default(obj, _options)
    self.extract!(obj, :id, :title, :nice_title)
  end

  def only_title(obj, _options)
    self.extract!(obj, :title)
  end
end

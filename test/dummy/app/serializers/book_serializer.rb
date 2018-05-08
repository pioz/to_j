module BookSerializer

  def default(obj, options)
    self.(obj, :id, :title, :good_title)
  end

  def only_title(obj, options)
    self.(obj, :title)
  end

end
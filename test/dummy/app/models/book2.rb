class Book2 < ApplicationRecord
  self.table_name = :books
  belongs_to :author2

  def good_title
    self.title.titleize
  end

  def serializable_hash(options = nil)
    super(only: [:id, :title], methods: :good_title).merge(options || {})
  end
end

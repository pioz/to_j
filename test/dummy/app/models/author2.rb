class Author2 < ApplicationRecord
  self.table_name = :authors
  has_many :books, dependent: :destroy, foreign_key: :author_id, class_name: 'Book2'

  def serializable_hash(options = nil)
    super(only: [:id, :name], include: :books).merge(options || {})
  end
end

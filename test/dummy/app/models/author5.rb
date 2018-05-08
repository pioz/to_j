class Author5 < ApplicationRecord
  self.table_name = :authors
  has_many :books, dependent: :destroy, foreign_key: :author_id, class_name: 'Book5'
end

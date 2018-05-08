class Author < ApplicationRecord
  include ToJ
  has_many :books, dependent: :destroy
end

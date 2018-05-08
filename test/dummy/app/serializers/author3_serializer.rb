class Author3Serializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :books
end
class Book < ApplicationRecord
  include ToJ
  belongs_to :author

  def nice_title
    self.title.titleize
  end
end

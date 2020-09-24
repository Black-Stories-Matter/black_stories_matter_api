class Book < ApplicationRecord
  validates :isbn, uniqueness: true, presence: true
  validates_presence_of :title
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
end

class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error # Prevent deletion if referenced
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true, uniqueness: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
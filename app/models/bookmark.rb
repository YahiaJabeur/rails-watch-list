class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates :movie_id, uniqueness: { scope: :list_id, message: "is already in this list" }
  validates :movie, presence: true
  validates :list, presence: true
end
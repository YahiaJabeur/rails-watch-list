class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy # Deletes associated bookmarks
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: true
end
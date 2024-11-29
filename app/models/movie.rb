class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  before_destroy :prevent_destroy_if_bookmarked

  private

  def prevent_destroy_if_bookmarked
    if bookmarks.any?
      raise ActiveRecord::InvalidForeignKey
    end
  end
end
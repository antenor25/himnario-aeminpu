class Song < ActiveRecord::Base
  has_many :song_sections, -> { order "ordered_by" }, dependent: :destroy

  validates_presence_of :title

  scope :alphabetical, -> { order "title" }
  scope :featured, -> { where("featured_order IS NOT NULL").order("featured_order") }
  scope :search, -> (term) { where("title ILIKE ?", "%#{term}%") if term.present? }

  def featured?
    !!featured_order
  end
end

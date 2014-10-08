class Song < ActiveRecord::Base

  validates :title, presence: true
  validates :artist, presence: true
  validates :bpm, presence: true
  validates :genre, presence: true
end

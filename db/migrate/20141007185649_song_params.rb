class SongParams < ActiveRecord::Migration
  def change
    create_table "songs", force: true do |t|
      t.string :title, null: false
      t.string :artist, null: false
      t.integer :bpm, null: false
      t.string :genre, null: false

      t.timestamps
    end
  end
end

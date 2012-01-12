class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :dj_id
      t.string :artist
      t.string :title
      t.string :disc
      t.string :identifier
      t.text :notes

      t.timestamps
    end
  end
end

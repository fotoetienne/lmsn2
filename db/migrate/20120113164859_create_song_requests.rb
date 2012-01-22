class CreateSongRequests < ActiveRecord::Migration
  def change
    create_table :song_requests do |t|
      t.integer :dj_id
      t.integer :song_id
      t.integer :singer_id
      t.string :name
      t.string :key
      t.string :comments
      t.boolean :archived

      t.timestamps
    end
  end
end

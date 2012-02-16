class AddSonglistToDjs < ActiveRecord::Migration
  def change
    add_column :djs, :songlist, :string
  end
end

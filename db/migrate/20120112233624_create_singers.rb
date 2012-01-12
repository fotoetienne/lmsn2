class CreateSingers < ActiveRecord::Migration
  def change
    create_table :singers do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :name
      t.integer :user_id
      t.boolean :public,        :default => false
      t.date :payed_through
      t.boolean :free,          :default => false
      t.string :promocode

      t.timestamps
    end
  end
end

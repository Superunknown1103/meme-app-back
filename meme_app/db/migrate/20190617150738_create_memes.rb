class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|
      t.string :link
      t.string :user_id
      t.integer :votes

      t.timestamps
    end
  end
end

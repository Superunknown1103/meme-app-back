class RemoveLinkFromMemes < ActiveRecord::Migration[5.2]
  def change
    remove_column :memes, :link, :string
  end
end

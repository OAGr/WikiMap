class AddParentIndexToCards < ActiveRecord::Migration
  def change
    add_index :cards, :parent_id
  end
end

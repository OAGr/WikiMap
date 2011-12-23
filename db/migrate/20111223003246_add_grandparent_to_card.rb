class AddGrandparentToCard < ActiveRecord::Migration
  def change
    add_column :cards, :grandparent_id, :integer
  end
end

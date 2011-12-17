class AddUidToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :uid, :integer
  end
end

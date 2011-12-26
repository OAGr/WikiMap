class ChangeAuthorizationtoFloat < ActiveRecord::Migration
  def up
    change_table :authorizations do |t|
         t.change :uid, 'bigint'
       end
  end

  def down
    change_table :authorizations do |t|
         t.change :uid, :integer
       end
  end
end

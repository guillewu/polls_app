class RemoveColumnQIdFromResponseTable < ActiveRecord::Migration
  def up
    remove_column :responses, :q_id
  end

  def down
  end
end

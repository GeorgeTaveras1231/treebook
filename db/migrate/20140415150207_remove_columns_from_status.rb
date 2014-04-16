class RemoveColumnsFromStatus < ActiveRecord::Migration
  def change
    remove_column :statuses, :commentable_type
    remove_column :statuses, :commentable_id
  end
end

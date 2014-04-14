class FixStatusColumnName < ActiveRecord::Migration
  def change
    rename_column :statuses, :likes, :likes_count
  end
end

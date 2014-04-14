class AddLikesToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :likes, :integer, default: 0
  end
end

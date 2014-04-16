class MakeStatusesCommentable < ActiveRecord::Migration
  def change
    add_column :statuses, :commentable_type, :string
    add_column :statuses, :commentable_id, :integer
  end
end

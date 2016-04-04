class RemoveDoneFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :done
  end
end

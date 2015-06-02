class AddBlockedToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :blocked, :boolean, default: false
  end
end

class AddInstanceStatusToGame < ActiveRecord::Migration
  def change
    add_column :games, :instance_status, :string
    add_column :games, :instance_id, :string
    add_column :games, :notes, :string
  end
end

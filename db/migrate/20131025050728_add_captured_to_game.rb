class AddCapturedToGame < ActiveRecord::Migration
  def change
    add_column :games, :captured, :boolean
  end
end

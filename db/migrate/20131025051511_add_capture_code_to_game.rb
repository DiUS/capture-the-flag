class AddCaptureCodeToGame < ActiveRecord::Migration
  def change
    add_column :games, :capture_code, :string
  end
end

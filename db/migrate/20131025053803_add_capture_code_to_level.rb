class AddCaptureCodeToLevel < ActiveRecord::Migration
  def change
    add_column :levels, :capture_code, :string
  end
end

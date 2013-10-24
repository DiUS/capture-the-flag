class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :source_url
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end

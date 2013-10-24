class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :level, index: true

      t.timestamps
    end
  end
end

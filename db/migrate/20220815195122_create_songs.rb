class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.text :title
      t.text :lyrics
      t.integer :length
      t.text :datestamp

      t.timestamps
    end
  end
end

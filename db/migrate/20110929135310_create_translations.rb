class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :key
      t.string :language
      t.references :user
      t.integer :votes_count, :default => 0
      t.text :translation

      t.timestamps
    end
  end
end

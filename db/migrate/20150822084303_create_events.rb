class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :initial_date
      t.integer :event_date_day, :default => 0
      t.text :comment, :default =>''
      t.date :last_date, index: true
      t.references :user, index: true, foreign_key: true
      t.references :event_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

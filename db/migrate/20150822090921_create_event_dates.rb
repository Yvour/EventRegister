class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.date :date
      t.references :event, index: true, foreign_key: true
      t.text :comment

      t.timestamps null: false
    end
  end
end

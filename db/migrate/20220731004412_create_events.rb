class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :event
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddCreatedFromToEvents < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      add_column :events, :created_from, :integer, default: 0
    end
  end
end

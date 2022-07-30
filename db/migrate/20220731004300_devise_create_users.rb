# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ''
      t.timestamps null: false
      t.string :provider, null: false
      t.string :full_name, null: false
      t.string :uid, null: false
      t.string :avatar_url, null: false
    end

    add_index :users, :email, unique: true
    add_index :users, [:provider, :uid]
  end
end

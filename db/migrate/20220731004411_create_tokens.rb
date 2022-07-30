class CreateTokens < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    create_table :api_tokens do |t|
      t.string :api_access_token
      t.string :api_refresh_token
      t.datetime :expired_at
      t.string :provider
      t.string :user_id

      t.timestamps
    end

    add_index :api_tokens, :user_id, algorithm: :concurrently
  end
end

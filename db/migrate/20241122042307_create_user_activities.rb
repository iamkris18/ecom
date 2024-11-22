class CreateUserActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :user_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.datetime :performed_at
      t.json :metadata

      t.timestamps
    end
  end
end

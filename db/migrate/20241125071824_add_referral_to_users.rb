class AddReferralToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :referral_code, :string, unique: true
    add_reference :users, :referred_by, foreign_key: { to_table: :users }, null: true
  end
end
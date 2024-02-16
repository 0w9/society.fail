class AddTraitsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :traits, :jsonb, default: {}
  end
end

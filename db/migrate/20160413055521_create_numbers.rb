class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.integer :user_id
      t.integer :value
    end

    add_index :numbers, [:user_id, :value], unique: true, name: 'index_unique_numbers'
  end
end

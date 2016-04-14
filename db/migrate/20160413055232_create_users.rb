class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :last_name
      t.string      :first_name
    end
    User.create(last_name: 'bob', first_name: 'hope')
  end
end

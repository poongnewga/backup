class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :gender
      t.integer :people
      t.string :location
      t.string :company
      t.string :day
      t.integer :week
      t.string :lunchtime
      t.boolean :matched

      t.timestamps
    end
  end
end

class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.integer :date
      t.string :day
      t.string :lunchtime
      t.string :center
      t.string :pin_m
      t.string :pin_f
      t.string :p_count
      t.string :company

      t.timestamps
    end
  end
end

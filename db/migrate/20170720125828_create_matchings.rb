class CreateMatchings < ActiveRecord::Migration[5.0]
  def change
    create_table :matchings do |t|
      t.belongs_to :group
      t.belongs_to :meeting

      t.timestamps
    end
  end
end

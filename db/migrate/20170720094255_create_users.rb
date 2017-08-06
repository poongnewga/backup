class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :password_digest
      t.string :age
      t.string :gender
      t.string :email
      t.string :company
      t.string :location
      t.string :lunchtime
      t.string :photo
      t.string :card
      t.string :token
      t.boolean :notice, default: true
      t.boolean :push, default: true
      t.string :push_token
      t.boolean :email_confirmed, default: false
      t.string :confirm_token
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
    t.string :encrypted_password
    t.string :password_histories
    t.timestamps
  end
end

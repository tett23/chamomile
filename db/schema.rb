ActiveRecord::Schema.define(version: 0) do
  create_table :users, force: true do |t|
    t.string :username, :default => ""
    t.string :provider, :null => false, :default => "database"
    t.string :uid,      :null => false, :default => ""
    t.string :email
    t.integer  :sign_in_count, :default => 0, :null => false
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    t.datetime :remember_created_at
    t.datetime :updated_at
    t.datetime :created_at
  end

  add_index :users, :username
end

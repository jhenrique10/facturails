class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :name
      t.string :address
      t.string :nif
      t.string :login
      t.string :email
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
      t.datetime :created_at
      t.datetime :updated_at
      t.string :remember_token
      t.datetime :remember_token_expires_at
    end
    
    User.create(:login => "admin", :name => "Admin", :password => "1234", :password_confirmation => "1234").save
  end

  def self.down
    drop_table "users"
  end
end

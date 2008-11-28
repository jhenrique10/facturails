class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :name,                      :string
      t.column :address,                   :text
      t.column :nif,                       :string
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end
    
    User.create(:login => "admin", :name => "Admin", :password => "1234", :password_confirmation => "1234").save
  end

  def self.down
    drop_table "users"
  end
end

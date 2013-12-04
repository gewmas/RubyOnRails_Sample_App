# rails generate migration add_admin_to_users admin:boolean

# bundle exec rake db:migrate
# bundle exec rake test:prepare

class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

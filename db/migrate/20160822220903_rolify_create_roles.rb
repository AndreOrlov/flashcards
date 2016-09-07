class RolifyCreateRoles < ActiveRecord::Migration
  # Basic roles
  @roles = ['user', 'moderator', 'admin']

  def self.up
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    # Add basic roles
    @roles.each do |role_name|
      Role.create! name: role_name
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
  end

  def self.down
    # Delete basic roles
    Role.where(name: @roles).destroy_all

    drop_table(:users_roles)
    drop_table(:roles)
  end
end

ActiveAdmin.register User do
  # Permitted parameters for strong parameters
  permit_params :email, :password

  # Filters
  filter :email
  filter :created_at
  # Remove any invalid filters like `user_activities_id`

  # Show User Activities on User's Show Page
  show do
    attributes_table do
      row :email
      row :created_at
    end

    panel "User Activities" do
      table_for user.user_activities do
        column :action
        column :performed_at
        column :metadata
      end
    end
  end
end

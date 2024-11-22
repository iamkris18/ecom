ActiveAdmin.register User do
  permit_params :email, :password

  filter :email
  filter :created_at

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

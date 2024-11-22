# app/admin/user_activities.rb
ActiveAdmin.register UserActivity do
  # Show which fields to display in the admin dashboard
  permit_params :user_id, :action, :performed_at, :metadata

  # Display the list of user activities
  index do
    selectable_column
    column :user_id
    column :user
    column :action
    column :performed_at
    column :metadata
    actions
  end

  # Allow filtering by user, action, or performed_at
  filter :user
  filter :action
  filter :performed_at
  filter :metadata

  # Customize the show page
  show do
    attributes_table do
      row :user
      row :action
      row :performed_at
      row :metadata
    end
  end

  # Customize the form for creating or editing a user activity
  form do |f|
    f.inputs do
      f.input :user
      f.input :action
      f.input :performed_at, as: :datetime_select
      f.input :metadata, as: :json
    end
    f.actions
  end
end

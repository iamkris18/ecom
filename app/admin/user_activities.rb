ActiveAdmin.register UserActivity do

  # Permitted parameters for strong parameters
  permit_params :user_id, :action, :performed_at, :metadata

  # Display columns in the index view
  index do
    selectable_column
    id_column
    column :user do |activity|
      link_to activity.user.email, admin_user_path(activity.user) if activity.user
    end
    column :action
    column :performed_at
    column :metadata
    actions
  end

  # Filters for searching
  filter :user, collection: proc { User.all.map { |u| [u.email, u.id] } }
  filter :action
  filter :performed_at

  # Show page details
  show do
    attributes_table do
      row :user do |activity|
        link_to activity.user.email, admin_user_path(activity.user) if activity.user
      end
      row :action
      row :performed_at
      row :metadata
    end
  end

  # Form for creating/editing records
  form do |f|
    f.inputs do
      f.input :user, collection: User.all.map { |u| [u.email, u.id] }
      f.input :action
      f.input :performed_at, as: :datepicker
      f.input :metadata
    end
    f.actions
  end
end

ActiveAdmin.register ::UserActivity do
  permit_params :user_id, :action, :performed_at, :metadata

  index do
    selectable_column
    column :user_id
    column("User")
    column :action
    column :performed_at
    column :metadata
    actions
  end

  action_item :download_csv, only: :index do
    link_to "Download CSV", admin_user_activities_path(format: :csv)
  end
  

  filter :user, as: :select, collection: -> { User.pluck(:email,:id) }
  filter :action
  filter :performed_at

  show do
    attributes_table do
      row :user
      row :action
      row :performed_at
      row :metadata
    end
  end
  

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

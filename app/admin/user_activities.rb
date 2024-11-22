ActiveAdmin.register UserActivity do
  permit_params :user_id, :action, :performed_at, :metadata

  index do
    selectable_column
    column :user_id
    column :user
    column :action
    column :performed_at
    column :metadata
    actions
  end

  filter :user
  filter :action
  filter :performed_at
  filter :metadata

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

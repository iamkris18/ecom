ActiveAdmin.register Cart do
  permit_params :user_id, :total_price # Add other attributes as needed

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    actions
  end

  filter :user
  filter :total_price

  form do |f|
    f.inputs do
      f.input :user
      f.input :total_price
    end
    f.actions
  end
end

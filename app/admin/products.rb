ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity

  index do
    selectable_column
    id_column
    column :name
    column :price
    actions
  end

  filter :name
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
    end
    f.actions
  end
end

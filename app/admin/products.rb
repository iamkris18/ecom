ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock_quantity
    actions
  end

  filter :name
  filter :price
  filter :stock_quantity

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
    end
    f.actions
  end
end

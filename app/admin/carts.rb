ActiveAdmin.register Cart do
  permit_params :user_id, :total_price

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

  # Show page configuration
  show do
    attributes_table do
      row :user

      # Calculate and display the total dynamically
      total_price = cart.cart_items.sum { |item| item.quantity * item.product.price }
      row "Total Price" do
        total_price
      end
    end

    # Show CartItems associated with this Cart
    panel "Cart Items" do
      table_for cart.cart_items do
        column :product
        column :quantity
        column "Subtotal Price" do |item|
          item.quantity * item.product.price
        end
      end
    end
  end
end

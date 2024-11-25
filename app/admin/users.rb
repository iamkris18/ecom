ActiveAdmin.register User do
  permit_params :email, :password

  filter :email
  filter :created_at

  # Customize the "Show" page
  show do
    attributes_table do
      row :email
      row :created_at
    end

    # Panel for displaying user activities
    panel "User Activities" do
      table_for user.user_activities do
        column :action
        column :performed_at
        column :metadata
      end
    end

    # Panel for displaying user invoices
    panel "User Invoices" do
      table_for user.cart.cart_items do
        column "Product" do |cart_item|
          cart_item.product.name
        end
        column "Quantity" do |cart_item|
          cart_item.quantity
        end
        column "Price" do |cart_item|
          cart_item.product.price
        end
      end

      # Add a link to view the invoice
      if user.cart.present? && user.cart.cart_items.any?
        div do
          link_to "View Invoice", view_invoice_admin_user_path(user), target: "_blank", class: "button"
        end
      else
        div do
          "No cart items available to generate an invoice."
        end
      end
    end
  end

  # Custom action to generate and view the invoice
  member_action :view_invoice, method: :get do
    cart = resource.cart

    if cart.nil? || cart.cart_items.empty?
      redirect_to admin_user_path(resource), alert: "No cart items to generate an invoice."
      return
    end

    invoice_pdf = InvoiceGenerator.new(resource, cart).generate_pdf

    send_data invoice_pdf, 
              type: 'application/pdf', 
              filename: "Invoice_#{Time.current.strftime('%Y%m%d%H%M%S')}.pdf", 
              disposition: 'inline'
  end
end
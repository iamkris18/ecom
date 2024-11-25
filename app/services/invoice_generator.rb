class InvoiceGenerator
    def initialize(user, cart)
      @user = user
      @cart = cart
    end
    
    def generate_pdf
      Prawn::Document.new do |pdf|
        pdf.text "Invoice", size: 30, style: :bold, align: :center
        pdf.move_down 20
  
        # User Details
        pdf.text "User Details", size: 18, style: :bold
        pdf.text "Email: #{@user.email}"
        pdf.move_down 10
  
        # Cart Items
        pdf.text "Cart Items", size: 18, style: :bold
  
        @cart.cart_items.each do |item|
          pdf.text "#{item.product.name} x #{item.quantity} - #{item.product.price * item.quantity}"
        end
  
        pdf.move_down 20
  
        # Total Price
        total_price = @cart.cart_items.sum { |item| item.quantity * item.product.price }
        pdf.text "Total: #{total_price}", size: 16, style: :bold
      end.render  # This returns the PDF as binary data.
    end
  end
  
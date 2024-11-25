require 'prawn'
require 'prawn/table'
class InvoiceGenerator

  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  def generate_pdf
    Prawn::Document.new(page_size: 'A4') do |pdf|
      # Header
      pdf.text "Invoice", size: 30, style: :bold, align: :center
      pdf.move_down 20

      # Company Details
      pdf.text "Royal Brothers", size: 16, style: :bold
      pdf.text "560/1, Boomi Plaza, 4th and 5th Floor, 4th Cross, CMH Road,", size: 10
      pdf.text "Indiranagar, Bengaluru, Bengaluru Urban, Karnataka 560 038", size: 10
      pdf.text "Phone: +917795687594 / +919019595595 | WhatsApp", size: 10
      pdf.text "Email: support@royalbrothers.com | Grievances: ceo@royalbrothers.com", size: 10
      pdf.move_down 10

      # Invoice Details
      pdf.text "Invoice Number: #{SecureRandom.hex(6).upcase}", size: 12, style: :bold
      pdf.text "Date: #{Time.current.strftime('%d %b %Y')}", size: 12
      pdf.move_down 20

      # Bill To and Ship To
      pdf.text "Bill To", size: 14, style: :bold
      pdf.text "#{@user.email}", size: 12
      pdf.move_down 10

      pdf.text "Ship To", size: 14, style: :bold
      pdf.text "Same as billing address", size: 12
      pdf.move_down 20

      # Cart Items
      pdf.text "Cart Items", size: 16, style: :bold
      pdf.move_down 10

      cart_data = [["Product", "Quantity", "Unit Price", "Total Price"]]
      @cart.cart_items.each do |item|
        cart_data << [
          item.product.name,
          item.quantity,
          item.product.price,
          (item.quantity * item.product.price).to_s
        ]
      end

      pdf.table(cart_data, header: true, row_colors: %w[EEEEEE FFFFFF], cell_style: { borders: [:bottom], padding: [5, 10] })
      pdf.move_down 20

      # Total Price
      total_price = @cart.cart_items.sum { |item| item.quantity * item.product.price }
      pdf.text "Total: #{total_price}", size: 16, style: :bold
      pdf.move_down 20

      # Terms and Conditions
      pdf.text "Terms and Conditions", size: 16, style: :bold, align: :left
      pdf.text "1. All sales are final and non-refundable.", size: 12
      pdf.text "2. Payment must be made within the specified due date.", size: 12
      pdf.text "3. Please contact us for any queries related to your order.", size: 12
      pdf.move_down 10

      # Footer
      pdf.text "Thank you for choosing Royal Brothers!", size: 14, style: :bold, align: :center
    end.render
  end
end
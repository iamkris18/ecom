class InvoiceMailer < ApplicationMailer
    default from: 'krishna@gmail.com'

    def send_invoice(user, invoice_pdf)
      @user = user
  
      attachments["Invoice_#{Time.current.strftime('%Y%m%d%H%M%S')}.pdf"] = invoice_pdf
      mail(to: @user.email, subject: 'Your Invoice')
    end

    def send_checkout(user, invoice_pdf)
      @user = user
  
      attachments["Invoice_#{Time.current.strftime('%Y%m%d%H%M%S')}.pdf"] = invoice_pdf
      mail(to: @user.email, subject: 'Your Cart is Missing You')
    end
end

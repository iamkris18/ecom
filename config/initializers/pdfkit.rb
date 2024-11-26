require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf' # Adjust the path to wkhtmltopdf if needed
  config.default_options = {
    page_size: 'A4',
    print_media_type: true
  }
end
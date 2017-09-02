im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:logo_path])

if im && File.exist?(im.pathname)
  pdf.image im.filename, vposition: :top, width: 100, scale: Spree::PrintInvoice::Config[:logo_scale]
end

pdf.grid([0,2], [2,0]).bounding_box do
  pdf.text Spree.t(printable.document_type, scope: :print_invoice), align: :right, style: :bold,color: 'FF0000', size: 30
  pdf.move_down 4
end
pdf.grid([0,3], [1,4]).bounding_box do
  pdf.text Spree.t(:invoice_number, scope: :print_invoice, number: printable.number), align: :right
  pdf.move_down 2
  pdf.text Spree.t(:invoice_date, scope: :print_invoice, date: I18n.l(printable.date)), align: :right
end

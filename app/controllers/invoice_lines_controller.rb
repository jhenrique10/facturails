class InvoiceLinesController < ApplicationController
  
  layout "invoice"
  
  # index
  #
  def index
    invoice = Invoice.find(params[:invoice_id])
    @invoice_lines = invoice.invoice_lines.find(:all)
  end
  
  # edit
  #
  def edit
    update_invoice_line_url
    
    @invoice_line = InvoiceLine.find(params[:id], :include => "invoice")
    @invoice = @invoice_line.invoice
    
    respond_to do |format|
      format.js { render :action => "edit_invoice_line" }
    end
  end
  
    
  # create
  #
  def create
    create_invoice_line_url
    
    @invoice = Invoice.find(params[:invoice_id], :include => :customer)
    @invoice_line = InvoiceLine.new(params[:invoice_line])
    
    if @invoice_line.valid?
      @invoice.invoice_lines << @invoice_line
      @invoice.save
      @invoice_line = InvoiceLine.new
    else
      flash[:invoice_line] = "Se produjo un error al guardar la línea de factura."
    end
    
    respond_to do |format|
      format.js { render :action => "invoice_lines" }
    end
  end
  
  # update
  #
  def update
    create_invoice_line_url
    
    @invoice_line = InvoiceLine.new
    invoice_line = InvoiceLine.find(params[:id])
    @invoice = invoice_line.invoice
    
    ok = invoice_line.update_attributes(params[:invoice_line])
    
    flash[:invoice_line] = ok ? "Línea de factura modificada correctamente" : "Se produjo un error al guardar la línea de factura"
    
    respond_to do |format|
      format.js { render :action => "invoice_lines" }
    end
  end

  
  # destroy
  #
  def destroy
    create_invoice_line_url
    
    invoice_line = InvoiceLine.find(params[:id])
    @invoice = invoice_line.invoice
    @invoice_line = InvoiceLine.new
    
    invoice_line.destroy
    
    respond_to do |format|
      format.js { render :action => "invoice_lines" }
    end
  end
  
  private
  # create_invoice_line_url
  def create_invoice_line_url
    @invoice_line_url = {:url => invoice_lines_path(params[:invoice_id])}
  end
  
  # update_invoice_line_url
  def update_invoice_line_url
    @invoice_line_url = {
      :url => invoice_line_path(params[:invoice_id], params[:id]),
      :html => { :method => :put }
    }
  end
end

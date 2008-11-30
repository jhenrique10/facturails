class InvoicesController < ApplicationController
  
  layout "invoice"
  
  before_filter :login_required, :set_section, :except => :public_invoices
  
  # index
  #
  def index
    @subsection = "invoices"
    conditions = params[:customer_id].nil? ? nil : ["customer_id = ?", params[:customer_id]] 
    
    @invoices = Invoice.paginate(
      :conditions => conditions,
      :order => "fiscal_year DESC, number DESC",
      :page => params[:page],
      :per_page => RESULTS_PER_PAGE
    )
    
    render :action => "invoices_list"
  end

  # new
  #
  def new
    @subsection = "invoices_form"
    @customers = Customer.find(:all)
    
    if @customers.length == 0
      flash[:notice] = "No hay ningún cliente dado de alta"
      render :template => "error"
    else
      @invoice = Invoice.new
      render :action => "invoice_form"
    end
  end
  
  # show
  #
  def show
    
    @invoice = Invoice.find(params[:id])
    html = render_to_string :template => "./pdf_invoice.html.erb", :layout => false
    
    respond_to do |format|
      
      #pdf
      #
      format.pdf do
        pdf = @invoice.to_pdf(html)
        send_data pdf, 
          :filename => "factura-#{@invoice.invoice_number}.pdf",
          :type => "application/pdf"
      end
    end
  end
  
  # create
  #
  def create
    
    @subsection = "invoices_form"
    
    @invoice = Invoice.new(params[:invoice])
    @invoice.customer = @customer = Customer.find(params[:invoice][:customer_id])
    @customers = Customer.find(:all)
    
    
    if @invoice.save
      redirect_to edit_invoice_path(@invoice)
    else
      render :action => "invoice_form"
    end
  end
  
  # edit
  #
  def edit
    @invoice = Invoice.find(params[:id], :include => :customer)
    @customer = @invoice.customer
    @invoice_line = InvoiceLine.new
    
    
    @customers = Customer.find(:all)
    
    respond_to do |format|
      format.html { render :action => "invoice_form" }
    end
  end
  
  # update
  #
  def update
    @invoice = Invoice.find(params[:id])
    
    if @invoice.update_attributes(params[:invoice])
      redirect_to edit_invoice_path(@invoice)
    else
      @customers = Customer.find(:all)
      @invoice_line = InvoiceLine.new

      render :action => "invoice_form"
    end
    
  rescue
     redirect_to edit_invoice_url(@invoice)
  end
  
  # destroy
  #
  def destroy
    Invoice.delete(params[:id])

    redirect_to invoices_path
  end
  
  
  # public_invoices
  #
  def public_invoices
    
    @customer = Customer.find(params[:customer_id], :include => :invoices)
    
    # check customer's private key
    
    if @customer.private_key != params[:private_key]
      render :nothing => true
      return
    end
    
    respond_to do |format|
      format.html { render :layout => false }
      format.xml { render :xml => @customer.invoices.to_xml(:include => :invoice_lines) }
    end
  end
  
  # search
  #
  def search
    @subsection = "invoices"    

    init_date = parse_date(params[:init_date])
    end_date = parse_date(params[:end_date])
    
    @invoices = Invoice.find(:all, :conditions => ["date BETWEEN ? AND ?", init_date, end_date])
    @total = @invoices.accumulate(:base, :total_irpf, :total_iva, :total)
    
    
    respond_to do |format|
      format.html { render :action => "search_results" }
    end
  end
 
  private
  # get_customer
  #
  def get_customer
    @customer = Customer.find(params[:customer_id]) if params[:customer_id]
  end
  
  def parse_date(date)
    if date =~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
      "#{$3}-#{$2}-#{$1}"
    end
  end
  
  # set_section
  #
  def set_section
    @section = "invoices"
  end
  
end
class CustomersController < ApplicationController
  
  before_filter :set_section
  
  layout "invoice"

  # index
  #
  def index
    @subsection = "customers"
    @customers = Customer.find(:all, :order => "name asc", :include => :invoices)
    
    render :action => "customers_list"
  end
  
  # new
  #
  def new
    @subsection = "customers_form"    
    @customer = Customer.new
    
    flash[:notice] = ""
    render :action => "customer_form"
  end
  
  # create
  #
  def create
    @subsection = "customers_form"    
    @customer = Customer.new(params[:customer])
    
    if @customer.save
      flash[:notice] = "Cliente guardado correctamente"
      redirect_to customers_path
    else
      flash[:notice] = "Se produjo un error al guardar el cliente."
      render :action => "customer_form"
    end
  end
  

  # edit
  #
  def edit
    @customer = Customer.find(params[:id])
    
    render :action => "customer_form"
  end
  
  # update
  #
  def update
    @subsection = "customers_form"    
    @customer = Customer.find(params[:customer][:id])
    
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Cliente guardado correctamente"
      redirect_to customers_path
    else
      flash[:notice] = "Se produjo un error al guardar el cliente."
      render :action => "customer_form"
    end
  end
  
  # destroy
  #
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    
    flash[:notice] = "Cliente borrado."
    
    redirect_to customers_path
    
    rescue ActiveRecord::ReferentialIntegrityProtectionError
    flash[:notice] = "No se pudo borrar el cliente porque tiene facturas asociadas."
    render :action => "customer_form"
  end
  
  # select_customer
  #
  def select
    @customer = Customer.find(params[:id])
    render :action => "customer_info", :layout => false
  end
  
  private
  
  # set_section
  #
  def set_section
    @section = "customers"
  end
end

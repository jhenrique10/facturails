class UsersController < ApplicationController
  
  layout "invoice"
  
  # edit
  #
  def edit
    @user = current_user
    @section = "preferences"
    @subsection = "change_data"
    
    flash[:notice] = ""
    
    render :action => "user_form"
  end
  
  # update
  #
  def update
    @section = "preferences"
    @subsection = "change_data"
    
    @user = current_user
    
    #params[:user][:password] = params[:user][:password_confirmation] = nil
    
    if @user.update_attributes(params[:user])
      @user.password = @user.password_confirmation = ''
      flash[:notice] = "Datos modificados correctamente."
    else
      flash[:notice] = "Se produjo un error al guardar los datos."
    end
    
    render :action => "user_form"
  end

end

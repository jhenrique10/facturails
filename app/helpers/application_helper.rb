# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # format_price
  #
  def format_price(number, unit = "&#8364;")
    price = number_to_currency(number, :unit => "", :delimiter => ".", :separator => ",")
    "#{price}#{unit}"
  end
  
  # error_for
  #
  def error_for(object, method = nil, options={})
  
    if method
      err = instance_variable_get("@#{object}").errors.on(method).to_sentence rescue instance_variable_get("@#{object}").errors.on(method)
    else
      err = @errors["#{object}"] rescue nil
    end
  
    options.merge!(:class=>'fieldWithErrors', :id=>"#{[object,method].compact.join('_')}-error", :style=>(err ? "#{options[:style]}":"#{options[:style]};display: none;"))
    if err
      content_tag("p",err || "", options )
    end
  end
  
  # public_invoices_path
  #
  def public_invoices_path(customer)
    "#{customer.id}/#{customer.private_key}/invoices"
  end
  
  # menu_option
  #
  def menu_option(label, path, section, current_section)
    selected = (section == current_section) ? " selected" : ""
    str = "<li class=\"#{section}#{selected}\">"
    str += link_to label, path
    str += "</li>"
    str
  end
  
  # pagination
  #
  def pagination(list, options = {})
    options[:prev_label] ||= "&laquo; Anterior"
    options[:next_label] ||= "Siguiente &raquo;"
    
    will_paginate list, options
  end
end

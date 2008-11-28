class Array
  def accumulate(*fields)
    
    results = {}
    fields.each {|field| results[field] = 0}
    
    
    self.each do |obj|
      fields.each do |field|
        results[field] += obj.send(field) if obj.respond_to?(field)
      end
    end
    
    results
  end
end
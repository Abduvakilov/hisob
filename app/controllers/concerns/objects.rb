module Objects

  def objects
    instance_variable_get("@#{controller_name}")
  end

  def object
    instance_variable_get("@#{controller_name.singularize}")
  end

  def model
  	controller_name.classify.constantize rescue nil
  end


  private

  def objects=(value)
  	instance_variable_set("@#{controller_name}", value)
  end

  def object=(value)
  	instance_variable_set("@#{controller_name.singularize}", value)
  end



end

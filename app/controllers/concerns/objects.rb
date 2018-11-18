module Objects

  def objects
    instance_variable_get("@#{controller_name}")
  end

  def object
    instance_variable_get("@#{controller_name.singularize}")
  end

  def model
    @model ||= begin
      controller_name.classify.constantize
    rescue NameError
      nil
    end
  end

  def filter_fields
    model.permitted_params
  end

  def path(object=nil)
    if object.is_a?(model) && object.persisted?
      send "#{controller_name.singularize}_path", object
    else
      send "#{controller_name}_path", object
    end
  end

  private

  def objects=(value)
  	instance_variable_set("@#{controller_name}", value)
  end

  def object=(value)
  	instance_variable_set("@#{controller_name.singularize}", value)
  end

end

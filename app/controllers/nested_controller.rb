class NestedController < ApplicationController

  def new
    self.object = model.new required_key
  end

  def index
    self.objects  = model.kept.where(required_key).page(params[:page]).per(rows_per_page)
    self.objects.order_values.prepend("#{params[:sort]} #{params[:dir]}") if params[:sort].present? && model.permitted_params.include?(params[:sort])
  end

  def path(options={})
    singular_path = "#{parent_class_name}_#{model.model_name.singular}_path"
    plural_path   = "#{parent_class_name}_#{model.model_name.plural}_path"
    if options.is_a?(model)
      if options.persisted?
        send(singular_path, id: options)
      else
        send(plural_path, options, required_key)
      end
    else
      if action = options.delete(:action)
        send("#{action}_#{singular_path}", options.merge(required_key))
      else
        send(plural_path, options.merge(required_key))
      end
    end
  end

  def self.path(options={})
    Rails.application.routes.url_helpers
    .send("#{parent_class_name}_#{model.model_name.plural}_path", options)
  end

  def parent_class
    @parent_class ||= self.class.parent or raise NotImplementedError
  end

  def parent_class_name
    @parent_class_name ||= parent_class.model_name.singular
  end

  # def controller_name
  #   super.delete_suffix('_nested')
  # end

  private

  def required_key
    { "#{parent_class_name}_id": params[:"#{parent_class_name}_id"] }
  end

end

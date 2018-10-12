SimpleForm::FormBuilder.class_eval do
  # https://github.com/plataformatec/simple_form/blob/3a99d65b082c4422e2f761b1a01e35dee9bd69ae/lib/simple_form/form_builder.rb#L484-L505
  def fetch_association_collection(reflection, options)
    options.fetch(:collection) do
      relation = reflection.klass.kept  # '.all' changed to '.kept'

      if reflection.respond_to?(:scope) && reflection.scope
        if reflection.scope.parameters.any?
          relation = reflection.klass.instance_exec(object, &reflection.scope)
        else
          relation = reflection.klass.instance_exec(&reflection.scope)
        end
      else
        order = reflection.options[:order]
        conditions = reflection.options[:conditions]
        conditions = object.instance_exec(&conditions) if conditions.respond_to?(:call)

        relation = relation.where(conditions) if relation.respond_to?(:where)
        relation = relation.order(order) if relation.respond_to?(:order)
      end

      relation
    end
  end
end

module LinkComponent
  def link(wrapper_options = nil)
    link_text(wrapper_options[:class]) if @reflection
  end

  def url
    options.fetch(:url) do
      "#{@reflection.klass.model_name.plural}_controller".camelize.constantize
        .path(options[:link_query] || {})
    end
  end

  def link_text(class_name)
    ApplicationController.helpers.tag.a(href: url, class: class_name, target: :_blank) do
      ApplicationController.helpers.icon('external-link-square-alt')
    end.html_safe
  end

end

SimpleForm.include_component(LinkComponent)

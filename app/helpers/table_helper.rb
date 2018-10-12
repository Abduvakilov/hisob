module TableHelper

  def th_sortable(_model, column)
    if _model.sortable_fields.include? column
      dir = column == params[:sort] && params[:dir] == "asc" ? "desc" : "asc"
      tag_attributes = " data-url='#{controller_path queries.merge(sort: column, dir: dir)}'
      class='sortable #{column}-column" + (column == params[:sort] ? " current #{params[:dir]}'" : "'")
    end
    "<th#{tag_attributes}>#{_model.human_attribute_name column}</th>"
  end

  def queries
    params.permit(controller.filter_fields, 'search', 'sort', 'dir')
  end

  def table_amount(object)
    content_tag :span, currency_precise_number(object.amount, object.account.currency, unit: true),
      class: "text-#{COLORS[object.type_id_before_type_cast/10]}"
  end

  def table_leftover(object)
    currency_precise_number(object.leftover, object.currency, unit: true)
  end

  def table_counter_party(object)
    if object.type_id_before_type_cast/10<2
      object.counter_party
    else
      object.counter_account
    end
  end

  %w[ total discount to_be_paid ].each do | field |
    define_method("table_#{field}") { | object |
      currency_precise_number(object.send(field), object.currency, unit: true)
    }
  end

  def table_gender(object)
    Employee.human_attribute_name("gender.#{object.gender}")
  end

  def date_filter_links(field_name, selected)
    res = ''
    Filter::PERIODS.each_with_index do |period, i|
      res += filter_link :date, i, i.to_s==selected, t(period, scope: :date)
    end
    content_tag :div, res.html_safe, class: 'list-group'
  end

  def filter_links(field_name, collection, selected)
    res = ''
    collection.each do |item|
      res += filter_link field_name, item.id, item.id.to_s==selected, item
    end
    content_tag :div, res.html_safe, class: 'list-group'
  end

  private

  COLORS = [ :success, :danger, :secondary ]

  def filter_link(field_name, value, checked, text)
    content_tag :label, onclick: 'this.form.submit()',
        class: "list-group-item list-group-item-action#{' active' if checked}" do
              (radio_button_tag field_name, value, checked, id: nil) +
              text
    end
  end

end

module ApplicationHelper
  def more_wrapped (&block)
    raw('<input type="checkbox" class="more-state" id="more"/><label for="more" class="more-trigger mb-4">' +
      t('views.more') + '</label><div class="more-wrap">' +
      capture(&block) + '</div>')
  end

  def th_sortable(app_model, column)
    if app_model.sortable_fields.include? column
      dir = column == params[:sort] && params[:dir] == "asc" ? "desc" : "asc"
      tag_attributes = " data-url='#{transactions_path sort: column, dir: dir}'" +
        " class='sortable" + (column == params[:sort] ? " current #{params[:dir]}'" : "'")
    end
    "<th#{tag_attributes}>#{app_model.human_attribute_name column}</th>"
  end

end

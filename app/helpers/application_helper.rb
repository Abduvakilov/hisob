module ApplicationHelper
  
  def more_wrapped (&block)
    raw('<input type="checkbox" class="more-state" id="more"/><label for="more" class="more-trigger mb-4">' +
      t('views.more') + '</label><div class="more-wrap">' +
      capture(&block) + '</div>')
  end


end

module ApplicationHelper
  def more_wrapped (&block)
    str = '<input type="checkbox" class="more-state" id="more"/><label for="more" class="more-trigger mb-4">Boshqa</label><div class="more-wrap">'
    str << capture(&block)
    str << '</div>'
    raw str
  end
end

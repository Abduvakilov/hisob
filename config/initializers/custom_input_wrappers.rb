SimpleForm.setup do |config|

  # horizontal custom multi select
  config.wrappers :hidden_account, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.wrapper :anchor_wrapper, tag: 'div', class: 'col', html: {'data-controller': 'account'} do |ba|
      ba.use :anchor, wrap_with: { tag: 'a', html: {href: 'javascript:void(0)', 'data-action': 'click->account#show'} }
      ba.wrapper :hide_wrapper, tag: 'div', class: 'd-none', html: {'data-target': 'account.hidden'} do |bb|
        bb.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |bc|
          bc.use :input, class: 'anchor_input custom-select mx-1', error_class: 'is-invalid', valid_class: 'is-valid', 'data-action': 'change->account#updateLeftover'
        end
      end
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'd-inline form-text text-muted ml-2' }
    end
  end


end

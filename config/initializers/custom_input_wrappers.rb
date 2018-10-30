SimpleForm.setup do |config|

  # horizontal custom multi select
  config.wrappers :hidden_account, tag: 'div', class: 'form-group row mb-0', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-2'
    b.wrapper :anchor_wrapper, tag: 'div', class: 'col-sm-10', html: {'data-controller': 'account'} do |ba|
      ba.use :anchor, wrap_with: { tag: 'a', html: {href: 'javascript:void(0)', 'data-action': 'click->account#show'} }
      ba.wrapper :hide_wrapper, tag: 'div', class: 'd-none', html: {'data-target': 'account.hidden'} do |bb|
        bb.wrapper tag: 'div' do |bc|
          bc.use :input, class: 'anchor_input custom-select mx-1', error_class: 'is-invalid', valid_class: 'is-valid', 'data-action': 'change->account#updateBalance'
        end
      end
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'd-inline form-text text-muted ml-2' }
    end
  end

  config.wrappers :table_row, tag: 'td' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, error_class: 'is-invalid'
  end

  config.wrappers :datepicker, tag: 'div', class: 'form-group',  html: {'data-controller': 'flatpickr'} do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper class: 'input-group' do |ba|
      ba.use :input, class: 'form-control', error_class: 'is-invalid', 'data-input': ''
      ba.wrapper :toggle, tag: :div, class: 'input-group-append',  html: { 'data-toggle': '' } do |bb|
        bb.wrapper tag: :a, class: 'input-group-text', html: {href: 'javascript:void(0)'} do |bc|
          bc.wrapper tag: :i, class: 'fas fa-calendar-alt' do end
        end
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'd-inline form-text text-muted ml-2' }

      end
    end
  end

end

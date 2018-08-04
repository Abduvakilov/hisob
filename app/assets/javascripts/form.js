function form($, undefined) {
    "use strict";
    
    let $form = $('form');
    if (!$form.length) {
        return;
    }

    function updateAccountDetail(e) {
        let $target = $(e.target);
        let place = $target.parent().next().find('#leftover');
        if (!$target.val()) {
            place.html('...');
            return;
        }
        $.ajax( { url: `/accounts/${$target.val()}.json` } )
            .done((json) => {
                place.html(json['leftover']);
            });
    }

    function unhideNext($this) {
        $this.next().removeClass('d-none')
    }

    $('.account select').change( updateAccountDetail );

    let currency;
    if ($('.currency input').length) {
        currency = new Cleave('.currency input', {
            numeral: true,
            numeralThousandsGroupStyle: 'thousand',
            numeralDecimalMark: ',',
            delimiter: ' ',
            numeralDecimalScale: 4,
            numeralIntegerScale: 15,
            numeralPositiveOnly: true
        });
    }
    $('input.date_picker').datepicker({
        format: "dd.mm.yy",
        todayBtn: 'linked',
        language: "uz-latn",
        todayHighlight: true,
        container: 'div.date_picker',
        autoclose: true,
    }).datepicker("setDate", 'now'); //<!-- TODO user setting -->
    const $anchor = $('a.anchor_input');
    $anchor.html($('select.anchor_input option:selected').text());
    $anchor.click( e => {
        let $target   = $(e.target);
        unhideNext($target);
        $target.remove()
    });
    $form.submit(() => {
        currency.element.value = currency.getRawValue()
        // date.element.value = cleave.getRawValue()
    });
}
(function($, undefined) {
    "use strict";

    function updateAccountDetails(accountId) {
        $.ajax({url: `/accounts/${accountId}.json`}).done(
            (json) => {
                $(".account #leftover").html(json.leftover);
            });
    }

    function unhideNext($this) {
        $this.next().removeClass('d-none')
    }

// 	// When ready.
//     $(function() {
    $(document).on('turbolinks:load', function() {

        let $form = $('form');
        if (!$form.length) {
            return;
        }
        const account = $('.account select');
        account.change((e) => {
            updateAccountDetails(account.val())
        });
        let currency = new Cleave('.currency input', {
            numeral: true,
            numeralThousandsGroupStyle: 'thousand',
            numeralDecimalMark: ',',
            delimiter: ' ',
            numeralDecimalScale: 4,
            numeralIntegerScale: 15,
            numeralPositiveOnly: true
        });
        $('input.date_picker').datepicker({
            format: "dd.mm.yy",
            todayBtn: 'linked',
            language: "uz-latn",
            todayHighlight: true,
            container: 'div.date_picker',
            autoclose: true,
        }).datepicker("setDate", 'now'); //<!-- TODO user setting -->
        const $anchor = $('a.anchor_input');
        $anchor.append($('select.anchor_input option:selected').text());
        $anchor.click(function() {
            let $this   = $(this);
            unhideNext($this);
            $this.remove()
        });
        $form.submit(() => {
            currency.element.value = currency.getRawValue()
            // date.element.value = cleave.getRawValue()
        });
    });
})(jQuery);
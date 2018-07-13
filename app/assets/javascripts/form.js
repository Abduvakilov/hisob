(function($, undefined) {
    "use strict";

    function updateAccountDetails(accountId) {
        $.ajax({url: `/accounts/${accountId}.json`}).done(
            (json) => {
                $(".account #leftover").html(json.leftover);
            });
    }
// 	// When ready.
//     $(function() {
    $(document).on('turbolinks:load', function() {

        let $form = $('form.new_transaction');
        if ($form.length) {
            let account = $('.account select');

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
                container: 'div.date_picker', //<!-- TODO user setting -->
                autoclose: true,
            }).datepicker("setDate",'now');

            // let date = new Cleave('.date input', {
            //     date: true,
            //     datePattern: ['d', 'm', 'y'],
            //     delimiter: '.'
            // });

// 		/**
// 		 * ==================================
// 		 * When Form Submitted
// 		 * ==================================
// 		 */
            $form.submit(() => {
                currency.element.value = currency.getRawValue()
                // date.element.value = cleave.getRawValue()
            });
        }
    });
})(jQuery);
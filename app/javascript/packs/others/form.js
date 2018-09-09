import Cleave from 'cleave.js';
export default function currency() {

    if (!document.getElementsByClassName('currency').length) {
        return;
    }

    let currency = new Cleave('.currency input', {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand',
        numeralDecimalMark: ',',
        delimiter: ' ',
        numeralDecimalScale: 4,
        numeralIntegerScale: 15,
        numeralPositiveOnly: true
    });

    document.getElementsByTagName('FORM')[0].addEventListener('submit', () => {
        currency.element.value = currency.getRawValue();
    });
}

window.toggleOpen = (e) => {
    e.currentTarget.parentElement.classList.toggle('collapsed');
}

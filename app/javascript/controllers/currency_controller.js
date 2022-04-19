import { Controller } from '@hotwired/stimulus';
import Cleave from 'cleave.js';

export default class extends Controller {

	initialize() {
		if (/android|iPhone|iPad/.test(navigator.userAgent)) {
			this.element.setAttribute('inputmode', 'decimal');
			this.element.setAttribute('pattern', '\\d*');
		}
		this.cleave = new Cleave(this.element, {
			numeral: true,
			numeralThousandsGroupStyle: 'thousand',
			numeralDecimalMark: ',',
			delimiter: ' ' || this.data.get('delimiter'),
			numeralDecimalScale: 4,
			numeralIntegerScale: 15,
			numeralPositiveOnly: true
		});
		this.getRawBeforeSubmit();
	}

	getRawBeforeSubmit() {
		this.element.form.addEventListener('beforesubmit', () => {
			this.element.value = this.cleave.getRawValue();
		});
	}

}
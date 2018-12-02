import { Controller } from 'stimulus';
import Cleave from 'cleave.js';

export default class extends Controller {

	initialize() {
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
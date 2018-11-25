import Flatpickr from 'stimulus-flatpickr';
import { Russian } from 'flatpickr/dist/l10n/ru.js';
import 'flatpickr/dist/flatpickr.min.css';

export default class extends Flatpickr {

	initialize() {
		this.config = {
			locale: Russian,
			clickOpens: false,
			// defaultDate: this.element.querySelector('input').value,
			allowInput: true,
			altFormat: 'd.m.y',
			time_24hr: true,
			altInput: true,
			wrap: true,
		};
	}
}
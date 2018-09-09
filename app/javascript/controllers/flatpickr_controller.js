import Flatpickr from 'stimulus-flatpickr';
import { Russian } from 'flatpickr/dist/l10n/ru.js';
import 'flatpickr/dist/flatpickr.min.css';

export default class extends Flatpickr {
	
  initialize() {
    this.config = {
      locale: Russian,
      allowInput: true,
      dateFormat: 'd.m.y',
    };
  }

}
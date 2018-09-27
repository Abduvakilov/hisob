import { Controller } from "stimulus"
import Cleave from 'cleave.js';

export default class extends Controller {

	initialize() {
    this.cleave = new Cleave(this.element, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand',
        numeralDecimalMark: ',',
        delimiter: ' ',
        numeralDecimalScale: 4,
        numeralIntegerScale: 15,
        numeralPositiveOnly: true
    });
    this.getRawOnSubmit();
  }

  getRawOnSubmit() {
  	this.element.form.addEventListener('submit', () => {
      this.element.value = this.cleave.getRawValue();
    })
  }

}
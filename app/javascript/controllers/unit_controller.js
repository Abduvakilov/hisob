import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'unit' ];

	updateUnit(e) {
		let unit = e.target.selectedOptions[0].getAttribute('unit');
		if(this.unitTarget.tagName == 'INPUT')
			this.unitTarget.value = unit;
		else
			this.unitTarget.innerText = unit;
	}

}
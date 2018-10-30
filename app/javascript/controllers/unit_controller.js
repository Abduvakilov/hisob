import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'unit' ];

	updateUnit(e) {
		this.unitTarget.innerText = e.target.selectedOptions[0].getAttribute('unit');
	}

}
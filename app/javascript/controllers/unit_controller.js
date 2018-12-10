import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'unit' ];

	updateUnit(e) {
		let unit = e.target.selectedOptions[0].getAttribute('unit');
		if(this.unitTarget.tagName == 'INPUT')
			this.unitTarget.value = unit;
		else
			this.unitTarget.textContent = unit;
	}

	updateUnits({target}) {
		let selected = target.selectedOptions[0];
		let unit     = selected.getAttribute('unit');
		let baseUnit = selected.getAttribute('baseUnit');

		Array.from(this.unitTarget.options).forEach(o => o.remove());
		[[baseUnit, true], [unit, false]].forEach(([u,v]) => {
			if(!u) return;
			let option = document.createElement('option');
			option.textContent = u;
			option.value       = v;
			this.unitTarget.add(option);
		})
	}

}
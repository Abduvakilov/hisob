import SelectrController from "./selectr_controller.js";

export default class extends SelectrController {

	static data = [];

	updateList(customerOrSupplier) {
		if(typeof customerOrSupplier === 'undefined') {
			this.selectr.add(this.constructor.data, true)
		} else {
			let value = this.selectr.getValue();
			this.selectr.removeAll();
			let dataToAdd = this.constructor.data
											.filter(e => e[customerOrSupplier]);
			this.selectr.add(dataToAdd);
			this.selectr.setValue(value||'');
		}
	}

  fillData() {
		Array.from(this.element).forEach( e => {
			this.constructor.data.push({
				value: e.value,
				text: e.innerText,
				customer: e.hasAttribute('cus'),
				supplier: e.hasAttribute('sup'),
			})
		})
  }

  initialize() {
  	super.initialize();
  	if (!this.constructor.data.length) this.fillData();
  }

}
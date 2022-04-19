import SelectrController from "./selectr_controller.js";

export default class extends SelectrController {

	static data = [];

  static roles = {
  	0: 'customer',
  	10: 'supplier',
  	12: 'employee'
  }

	updateList(typeID) {
		let role = this.constructor.roles[typeID]
		if(typeof role === 'undefined') {
			this.selectr.add(this.constructor.data, true)
		} else {
			let value = this.selectr.getValue();
			this.selectr.removeAll();
			let dataToAdd = this.constructor.data
											.filter(e => e[role]);
			this.selectr.add(dataToAdd);
			this.selectr.setValue(value||'');
		}
	}

  fillDataAndRemove() {
  	this.constructor.data = [];
		Array.from(this.element).forEach( e => {
			let cp = {
				value: e.value,
				text: e.innerText,
				customer: e.hasAttribute('cus'),
				supplier: e.hasAttribute('sup'),
				contract: e.getAttribute('contract')
			}
			this.constructor.data.push(cp)
			let role = this.constructor.roles[this.typeID]
			if(role && !cp[role]) e.remove()
		})
  }

  initialize() {
  	this.fillDataAndRemove();
  	super.initialize();
  }

  get typeID() {
		return document.querySelector('[data-transaction-target="type"]').value;
	}

}
import PersistencyController from "./persistency_controller.js";

export default class extends PersistencyController {
  static targets = [ 'counterParties', 'type' ];

  static customerOrSupplier = {
  	0: 'customer',
  	1: 'supplier',
  	10: 'supplier', 11: 'supplier',
  	12: 'employee'
  }

  updateCounterParties() {
  	let id = this.typeTarget.value;
		this.counterParties.updateList(this.constructor.customerOrSupplier[id]);
  }


  get counterParties() {
    return this.application.getControllerForElementAndIdentifier(this.counterPartiesTarget, 'counter-parties')
  }

  initialize() {
    super.initialize();
  	Promise.resolve().then(() => {
	  	this.updateCounterParties();
	  })
  }

}
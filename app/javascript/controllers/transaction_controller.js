import PersistencyController from "./persistency_controller.js";

export default class extends PersistencyController {
  static targets = [ 'type', 'counterParties', 'conversionHidden' ];

  static customerOrSupplier = {
  	0: 'customer',
  	1: 'supplier',
  	10: 'supplier', 11: 'supplier',
  	12: 'employee'
  }

  update() {
    this.updateCounterParties();
    this.showConversionFields();
  }

  updateCounterParties() {
  	let id = this.typeTarget.value;
		this.counterParties.updateList(this.constructor.customerOrSupplier[id]);
  }


  get counterParties() {
    return this.application.getControllerForElementAndIdentifier(this.counterPartiesTarget, 'counter-parties')
  }

  showConversionFields() {
    if (this.typeTarget.value == 1 || this.typeTarget.value == 11 )
      this.conversionHiddenTarget.classList.remove('d-none');
    else
      this.conversionHiddenTarget.classList.add('d-none');
  }

  initialize() {
    super.initialize();
  	Promise.resolve().then(() => {
	  	this.update();
	  })
  }

}
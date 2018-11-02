import PersistencyController from "./persistency_controller.js";

export default class extends PersistencyController {
  static targets = [ 'type', 'counterParties', 'conversionHidden' ];

  static customerOrSupplier = {
  	0: 'customer',
  	10: 'supplier',
  	12: 'employee'
  }

  update() {
    this.updateCounterParties();
    this.showConversionFields();
    this.disableContractField();
  }

  updateCounterParties() {
  	let id = this.typeTarget.value;
		this.counterParties.updateList(this.constructor.customerOrSupplier[id]);
  }

  get counterParties() {
    return this.application.getControllerForElementAndIdentifier(this.counterPartiesTarget, 'counter-parties')
  }

  showConversionFields() {
    if (this.typeTarget.value == 11)
      this.conversionHiddenTarget.classList.remove('d-none');
    else
      this.conversionHiddenTarget.classList.add('d-none');
  }

  disableContractField() {
    if (!['0','10'].includes(this.typeTarget.value))
      this.contract.parentElement.style.display = 'none'
    else
      this.contract.parentElement.removeAttribute('style')
  }

  get contract() {
    return document.querySelector('[data-target="contract.contract"]')
  }

  initialize() {
    super.initialize();
  	Promise.resolve().then(() => {
	  	this.update();
	  })
  }

}
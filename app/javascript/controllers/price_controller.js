import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

	static targets = ['price']
	static productDetails = [];

	get contractID() {
		return document.querySelector('[data-contract-target="contract"]').value;
	}

	get products(){
		return this.constructor.productDetails;
	}

	set price(productObject) {
		let lastPrice = productObject['contract']['last_price'];
		if(lastPrice)
			this.application.getControllerForElementAndIdentifier(this.priceTarget,'currency').cleave.setRawValue(lastPrice);
	}

	updatePrice(e) {
		if(!this.contractID || !e.target.value) return;
		let product  = this.products.find( el => {
			return el['id'] == e.target.value && el['contract']['id'] == this.contractID;
		});
		if (product){  // if fetched before
			this.price = product;
			return;
		}
    fetch(`/products/${e.target.value}.json?contract_id=${this.contractID}`, {credentials: 'same-origin'})
      .then( res => res.json() )
      .then( json => {
      	this.products.push(json);
        this.price = json;
    });
	}

}
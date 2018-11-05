import { Controller } from "stimulus";

export default class extends Controller {

	static targets = ['contract'];
	static counterPartyDetails = [];

	get cps() {
		return this.constructor.counterPartyDetails
	}

	updateContract(e) {

		if (e.target.selectedOptions.length==0) return;

		let contractID = e.target.selectedOptions[0].getAttribute('contract')

		if(contractID === '') {
			
			this.contractTarget.parentElement.classList.remove('d-none')

			let cp = this.cps.find(el => el['id'] == e.target.value); // find counter_party from array fetched before

			if (cp) {  // if fetched before
				this.options = cp['contracts'];
				return;
			}

			fetch( `/counter_parties/${e.target.value}.json` )
	      .then( res => res.json() )
	      .then( json => {
	      	this.cps.push(json);
	        this.options = json['contracts'];
	    });

		} else {

			this.removeContracts();

			let option = document.createElement('option');
			option.value = contractID;
			this.contractTarget.append(option);

			this.contractTarget.parentElement.classList.add('d-none');
		}
	}

	set options(contactsObjectsArray) {
		this.removeContracts();
		contactsObjectsArray.forEach(e=>{
			let option = document.createElement('option');
			option.value = e['id'];
			option.text = e['name'];
			this.contractTarget.append(option);
		})
	}

	removeContracts() {
		this.contractTarget.innerHTML = '';
	}

}
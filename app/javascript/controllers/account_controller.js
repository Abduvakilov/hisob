import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'leftover', 'hidden' ];

	static accountDetails = [];

	get accounts(){
		return this.constructor.accountDetails;
	}

	set leftover(json) {
		this.leftoverTarget.innerText = json['leftover']+' '+json['currency']['code'];
	}

  show(e) {
    this.hiddenTarget.classList.remove('d-none');
    e.target.remove()
  }

  updateLeftover(e) {
		if (this.accounts.some(el => el['id'] == e.target.value)){
			this.leftover = this.accounts.find(el => el['id'] == e.target.value);
			return;
		}
    fetch( `/accounts/${e.target.value}.json` )
      .then( res => res.json() )
      .then( json => {
      	this.accounts.push(json)
        this.leftover = json
      });
  }

}
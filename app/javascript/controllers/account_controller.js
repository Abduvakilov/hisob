import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'leftover', 'hidden' ];

	static accountDetails = [];

  connect() {

  }

	get accounts(){
		return this.constructor.accountDetails;
	}

	set leftover(json) {
		this.leftoverTarget.innerText = json['leftover'].toLocaleString('ru-RU')+' '+json['currency']['code'];
	}

  show() {
    if (this.hiddenTarget.classList.contains('d-none')) {
      this.hiddenTarget.classList.remove('d-none');
      this.hiddenTarget.previousSibling.remove()
    }
  }

  updateLeftover(e) {
    this.show();
		if (this.accounts.some(el => el['id'] == e.target.value)){  // if fetched before
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
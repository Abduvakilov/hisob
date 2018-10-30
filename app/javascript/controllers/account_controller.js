import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'balance', 'hidden' ];

	static accountDetails = [];

	get accounts(){
		return this.constructor.accountDetails;
	}

	set balance(json) {
		this.balanceTarget.innerText = json['balance'].toLocaleString('ru-RU')+' '+json['currency']['name'];
	}

  show() {
    if (this.hiddenTarget.classList.contains('d-none')) {
      this.hiddenTarget.classList.remove('d-none');
      this.hiddenTarget.previousSibling.remove()
    }
  }

  updateBalance(e) {
    if (this.hasHiddenTarget) this.show();
		if (this.accounts.some(el => el['id'] == e.target.value)){  // if fetched before
			this.balance = this.accounts.find(el => el['id'] == e.target.value);
			return;
		}
    fetch( `/accounts/${e.target.value}.json` )
      .then( res => res.json() )
      .then( json => {
      	this.accounts.push(json);
        this.balance = json;
      });
  }

}
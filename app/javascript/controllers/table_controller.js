import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'price', 'amount', 'totalAmount', 'total', 'discount', 'toBePaid' ];

	update() {
		this.updateAmount();
		if (this.hasTotalTarget) this.updateTotals();
	}

	updateAmount() {
		this.totalAmountTarget.innerText = this.totalAmount;
	}

	get totalAmount() {
		return this.amountTargets.reduce( ( sum, e ) => {
			return sum + (this.isDestroyed(e) ? 0 : Number(e.value))
		}, 0);
	}

	updateTotals() {
		this.totalTarget.innerText = this.total.toLocaleString('ru-RU');
		this.toBePaidTarget.innerText = (this.total - this.currencyRawValue(this.discountTarget)).toLocaleString('ru-RU');
	}

	currencyRawValue(e) {
		return this.application.getControllerForElementAndIdentifier(e, 'currency').cleave.getRawValue();
	}

	get total() {
		return this.priceTargets.reduce( (sum, e, i) => {
			return sum + ( this.isDestroyed(e) ? 0 : this.currencyRawValue(e) * this.amountTargets[i].value);
		}, 0)
	}

	isDestroyed(e) {
		return e.parentElement.parentElement.classList.contains('d-none');
	}

}
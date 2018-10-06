import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'price', 'amount', 'totalAmount', 'total', 'discount', 'toBePaid' ]

	update() {
		this.updateAmount();
		this.updateTotals();
		this.updateToBePaid();
	}

	updateAmount() {
		this.totalAmountTarget.innerText = this.totalAmount;
	}

	get totalAmount() {
		return this.amountTargets.reduce( ( sum, e ) => sum + Number(e.value), 0);
	}

	updateTotals() {
		this.totalTarget.innerText = this.total;
	}

	get total() {
		return this.priceTargets.reduce( (sum, e, i) => {
			return sum + (Number(e.value) * Number(this.amountTargets[i].value));
		}, 0)
	}

	updateToBePaid() {
		this.toBePaidTarget.innerText = this.total - this.discountValue;
	}

	get discountValue() {
		return this.application.getControllerForElementAndIdentifier(this.discountTarget, 'currency').cleave.getRawValue();
	}

}
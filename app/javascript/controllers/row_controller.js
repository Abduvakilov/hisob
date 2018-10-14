import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'no', 'minus' ];

	connect() {
		if (!this.isFilled) {
			this.data.set('notFilled', 1);
			this.minusTarget.classList.add('d-none');
			this.noTarget.innerText = '';
			if(this.allRows.length!==1) this.copyInputNames(this.element);
		} else {
			this.noTarget.innerText = this.no
		}
	}

	copy(e) {
		if (this.data.has('notFilled')){
			this.replaceInputNames(this.element);
			let value = e.target.value;
			e.target.value = '';
			let clone = this.element.cloneNode(true);
			this.element.after(clone);
			this.minusTarget.classList.remove('d-none');
			this.data.delete('notFilled');
			this.number();
			e.target.value = value;
		}
	}

	SELECTOR = ':not([data-save]) > input, :not([data-save]) > select';

	copyInputNames(parent) {
		Array.from(parent.querySelectorAll(this.SELECTOR)).forEach( e => {
			if (e.hasAttribute('required')) e.setAttribute('data-required', '');
			e.setAttribute('data-name', e.name.replace(this._id-1, this._id));
			['name', 'required', 'aria-required'].forEach(a=>e.removeAttribute(a));
		})
	}

	replaceInputNames(parent) {
		Array.from(parent.querySelectorAll(this.SELECTOR)).forEach( e => {
			if (e.hasAttribute('data-required')) {
				e.setAttribute('required', '');
			}
			if (!e.name) e.name = e.getAttribute('data-name');
			['data-name', 'data-required'].forEach(a=>e.removeAttribute(a));
		})
	}

	remove() {
		this.element.classList.add('d-none');
		this.numberAll();
		this.copyInputNames(this.element);
		if (!this.minusTarget.previousElementSibling) {
			this.element.remove();
		}
	}

	numberAll() {
		let items = this.allRows;
		for(let i=0; i<items.length; i++) {
			this.application.getControllerForElementAndIdentifier(items[i], 'row').number();
		}
		if (items.length===1)
			this.replaceInputNames(items[0]);
	}

	number() {
		this.noTarget.innerText = this.no;
	}

	get isFilled() {
		return Boolean(this.element.querySelector('select:checked[value], input[value]:not([type=hidden], .d-none)'));
	}

	get _id() {
		return Array.from(this.allRows).indexOf(this.element)
	}

	get no() {
		return this._id+1;
	}

	get allRows() {
		return this.element.parentElement.querySelectorAll('tr:not(.d-none)');
	}

}
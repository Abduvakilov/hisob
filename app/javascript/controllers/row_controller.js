import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ 'no', 'minus' ]

	connect() {
		if (!this.isFilled) {
			this.data.set('notFilled', 1);
			this.minusTarget.classList.add('d-none')
			this.noTarget.innerText = ''
			this.copyInputNames(this.element);
		} else {
			this.noTarget.innerText = this.no
		}
	}

	copy(e) {
		if (this.data.has('notFilled')){
			this.replaceInputNames(this.element);
			let value = e.target.value;
			e.target.value = '';
			console.log(this.element)
			let clone = this.element.cloneNode(true)
			this.element.after(clone);
			console.log(clone)
			this.minusTarget.classList.remove('d-none');
			this.data.delete('notFilled');
			this.number();
			e.target.value = value;
		}
	}

	copyInputNames(parent) {
		Array.from(parent.querySelectorAll('input, select')).forEach( e => {
			e.setAttribute('data-name', e.name.replace(this._id-1, this._id));
			e.removeAttribute('name');
		})
	}

	replaceInputNames(parent) {
		Array.from(parent.querySelectorAll('input, select')).forEach( e => {
			e.name = e.getAttribute('data-name');
			e.removeAttribute('data-name');
		})
	}

	remove() {
		if (this.minusTarget.previousSibling) {
			this.element.classList.add('d-none');
		} else {
			this.element.remove();
		}
		this.numberAll();
	}

	numberAll() {
		for(let i=0; i<this.allRows.length; i++) {
			this.application.getControllerForElementAndIdentifier(this.allRows[i], 'row').number();
		}
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
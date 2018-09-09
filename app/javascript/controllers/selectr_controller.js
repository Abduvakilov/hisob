import { Controller } from "stimulus"
import Selectr from 'mobius1-selectr/src/selectr';
import PersistencyController from './persistency_controller.js'
import 'mobius1-selectr/src/selectr.css'

export default class extends Controller {

	initialize() { //don't use connect, disconnect with 'new Selectr'. otherwise you get endless loop
		this.selectr = new Selectr(this.element, {
			pagination: 25,
			placeholder: this.data.get('placeholder') || 'Tanlang: '
		});
		this.destroyBeforeCache();
		this.saveOnChange();
		this.setFromStorage();
	}

	destroyBeforeCache() {
		document.addEventListener('turbolinks:before-cache', function() {
			this.selectr.destroy();
		}.bind(this), { once: true });
	}

	saveOnChange() {
		this.selectr.on('selectr.change', () => {
			localStorage[this.element.name] = this.element.value;
		})
	}

	setFromStorage() {
		let savedValue = localStorage[this.element.name]
		if (savedValue) this.selectr.setValue(savedValue);
		console.log(this.selectr.getValue())
	}

}
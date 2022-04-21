import { Controller } from '@hotwired/stimulus';
import Selectr from 'mobius1-selectr/src/selectr';
import 'mobius1-selectr/src/selectr.css';

export default class extends Controller {

	initialize() { //don't use connect, disconnect with 'new Selectr'. otherwise you get endless loop
		this.selectr = new Selectr(this.element, {
			pagination: 25,
			clearable: true,
			defaultSelected: false,
			placeholder: this.data.get('placeholder') || 'Tanlang: ',
			messages: {
				noResults: 'Xech nima topilmadi.',
				noOptions: 'Xech nima yo‘q.',
				searchPlaceholder: 'Qidirish...',
				maxSelections: '', // "A maximum of {max} items can be selected.",
				tagDuplicate: '' // "That tag is already in use"
			}
		});
		this.destroyBeforeCache();
		if(this.element.id.startsWith('new')) {
			this.saveOnChange();
			this.setFromStorage();
		}
	}

	destroyBeforeCache() {
		document.addEventListener('turbolinks:before-cache', function() {
			this.selectr.destroy();
		}.bind(this), { once: true });
	}

	saveOnChange() {
		this.selectr.on('selectr.change', () => {
			localStorage[this.element.name] = this.element.value;
		});
	}

	setFromStorage() {
		let savedValue = localStorage[this.element.name];
		if (savedValue) this.selectr.setValue(savedValue);
		else this.selectr.setValue('');
	}

}
import { Controller } from "stimulus";

export default class extends Controller {

	saveInput(){
		if (this.name.includes('[')) {
			switch (this.type){ case 'checkbox': case 'radio':
				this.checked ? localStorage[this.name] = 'on' : localStorage.removeItem(this.name); break;
			default:
				localStorage[this.name] = this.value;
			}
		}
	}

	connect() {
		if (this.element.id.startsWith('new')) {
			this.trackInput();
			this.onSubmitClearStorage();
		}
	}

	trackInput() {
		this.element.querySelectorAll('input,select:not([data-custom-track]),textarea').forEach(e => {
			let event;
			switch (e.type) {
			case 'checkbox': case 'radio': case 'select-one':
				event = 'change';
				if (localStorage[e.name]==='on') e.checked = true;
				break;
			default:
				event = 'input';}

			e.addEventListener(event, this.saveInput);

			if (localStorage[e.name]) {
				e.value = localStorage[e.name];
		  	Promise.resolve().then(() => {
					e.dispatchEvent(new Event('change'));
				})
				if (!this.modelName) {
					this.modelName = e.name.split('[')[0];
				}
			}
		})
	}

	onSubmitClearStorage() {
		this.element.addEventListener('submit', () => {
		  for (let i = 0; i < localStorage.length; i++) {
		  	let key = localStorage.key(i);
				if (key.includes(this.modelName)) localStorage.removeItem(key);
			}
		})
	}

}
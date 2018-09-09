import currency from './form';
import './alert';
import './icons';
import { dom } from '@fortawesome/fontawesome-svg-core';

document.addEventListener('turbolinks:load', function() {


	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = linkedEls[i].tagName == 'TR' ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, e => {
			Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
		})
	}

	currency();

	dom.i2svg();
	

});

import { form, submit } from './form';
import './alert';
import { library, dom } from '@fortawesome/fontawesome-svg-core';
import { faMoneyBillAlt, faCaretSquareLeft, faMoneyCheckAlt, faAppleAlt, faDollarSign, faMapMarkedAlt, faShapes } from '@fortawesome/free-solid-svg-icons';
library.add(faMoneyBillAlt, faCaretSquareLeft, faMoneyCheckAlt, faAppleAlt, faDollarSign, faMapMarkedAlt, faShapes);
document.addEventListener('turbolinks:load', function() {


	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = linkedEls[i].tagName == 'TR' ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, e => {
			Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
		})
	}

	form();


	dom.i2svg();


});

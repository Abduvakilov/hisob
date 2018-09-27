import { dom } from '@fortawesome/fontawesome-svg-core';
import './icons';
import './alert';

document.addEventListener('turbolinks:load', function() {

	dom.i2svg();

	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = linkedEls[i].tagName == 'TR' ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, e => {
			Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
		})
	}

});

window.toggleOpen = (e) => {
    e.currentTarget.parentElement.parentElement.classList.toggle('open');
}

window.dismissModal = () => {
    let modal = document.getElementsByClassName('modal')[0];
    let backdrop = document.getElementsByClassName('modal-backdrop')[0];
    [modal, backdrop].forEach( e => {
        e.classList.remove('show');
        setTimeout(()=> {
            e.style.display = 'none';
        }, 150);
    });
}
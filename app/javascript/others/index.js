import Turbolinks from 'turbolinks';
import './icons';
import './alert';

Turbolinks.start();

window.touch = 'ontouchstart' in document.documentElement;

document.addEventListener('turbolinks:load', function() {
	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = (linkedEls[i].tagName === 'TR' && !window.touch) ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, linkEventHandler);
	}
});

function linkEventHandler(e) {
	Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
	window.getSelection().removeAllRanges();
}


window.toggleOpen = (e) => {
	e.currentTarget.parentElement.parentElement.classList.toggle('open');
};

window.dismissModal = () => {
	let modal = document.getElementsByClassName('modal')[0];
	let backdrop = document.getElementsByClassName('modal-backdrop')[0];
	[modal, backdrop].forEach( e => {
		e.classList.remove('show');
		setTimeout(()=> {
			e.style.display = 'none';
		}, 150);
	});
};

window.clearFormValues = element => {
	const formInputTagnames = ['INPUT', 'SELECT', 'TEXTAREA'];
	if (formInputTagnames.includes(element.tagName))
		element.value= '';
	else
		element.querySelectorAll(formInputTagnames.join(','))
			.forEach(e => e.value= '');
};

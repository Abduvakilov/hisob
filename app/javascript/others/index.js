import "@hotwired/turbo-rails";
import './icons.js';
import alertTimeout from './alert.js';
import formSubmit from './submit.js';

window.touch = 'ontouchstart' in document.documentElement;

document.addEventListener('turbo:before-cache', function() {
	let alert = document.querySelector('.alert');
	if(alert) alert.remove();
});

document.addEventListener('turbo:load', function() {
	alertTimeout();
	linkRows();
	formSubmit();
  console.log('1')
});

function linkRows(){
	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = (linkedEls[i].tagName === 'TR' && !window.touch) ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, linkEventHandler);
	}
}

function linkEventHandler(e) {
	Turbo.visit(e.currentTarget.getAttribute('data-url'));
	window.getSelection().removeAllRanges();
}

window.toggleOpen = (e) => {
	e.currentTarget.parentElement.parentElement.classList.toggle('open');
};

window.dismissModal = () => {
	let modal = document.querySelector('.modal');
	let backdrop = document.querySelector('.modal-backdrop');
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
			.forEach(e => e.value = '');
};

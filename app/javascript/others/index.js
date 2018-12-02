import Turbolinks from 'turbolinks';
import './icons';
import alertTimeout from './alert';

Turbolinks.start();

window.touch = 'ontouchstart' in document.documentElement;

document.addEventListener('turbolinks:load', function() {
	alertTimeout();
	linkRows();
	formSubmit();
});

function linkRows(){
	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = (linkedEls[i].tagName === 'TR' && !window.touch) ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, linkEventHandler);
	}
}

function linkEventHandler(e) {
	Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
	window.getSelection().removeAllRanges();
}

function formSubmit() {
	for(let i = 0; i < document.forms.length; i++) {
		const form = document.forms[i];
		if (form.method == 'get') {
			form.addEventListener('submit', (e) => {
				e.stopImmediatePropagation(); e.preventDefault();
				const entries = [...new FormData(e.target).entries()];
				const params = '?' + entries.map(e => e.map(encodeURIComponent).join('=')).join('&');
				Turbolinks.visit(form.action + params);
			});
		} else if(!form.hasAttribute('data-local')) {
			form.addEventListener('submit', (e) => {
				form.dispatchEvent(new Event('beforesubmit'));
				const token = document.querySelector('meta[name=csrf-token]').content;
				e.stopImmediatePropagation(); e.preventDefault();
				let body = new FormData(form);
				body.set('authenticity_token', token);
				fetch(form.action, {
					method: form.method, credentials: 'same-origin',
					body: body
				}).then(res => {
					let url = res.headers.get('location');
					if(url) {
						Turbolinks.visit(url);
						return;
					}
					res.text().then(html => {
						form.outerHTML = html;
						Turbolinks.dispatch('turbolinks:load');
						scrollTo(0, 0);
					});
				});
			});
		}
	}
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

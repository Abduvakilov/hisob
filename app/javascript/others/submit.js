export default function() {
	for(let i = 0; i < document.forms.length; i++) {
		const form = document.forms[i];
		if (form.method == 'get') {
			form.addEventListener('submit', getSubmitListener);
		} else if(!form.hasAttribute('data-local')) {
			form.addEventListener('submit', postSubmitListener);
		}
	}
}

function getSubmitListener(e) {
	e.stopImmediatePropagation(); e.preventDefault();
	const entries = [...new FormData(e.target).entries()];
	const params = '?' + entries.map(e => e.map(encodeURIComponent).join('=')).join('&');
	Turbo.visit(e.target.action + params);
}

function postSubmitListener(e) {
	let form = e.target;
	e.stopImmediatePropagation(); e.preventDefault();
	form.dispatchEvent(new Event('beforesubmit'));
	let buttons = form.querySelectorAll('[type=submit]')
	buttons.forEach(el=>el.disabled = true);

	const token = document.querySelector('meta[name=csrf-token]');
	let body = new FormData(form);
	if(token) body.set('authenticity_token', token.content);
	fetch(form.action, {
		method: form.method, credentials: 'same-origin', redirect: 'manual',
		body: body
	}).then(res => {

		let url = res.redirected ? res.url : res.headers.get('location');
		if(url) {
			Turbo.visit(url);
			buttons.forEach(el=>el.disabled = false);
			return;
		}

		res.text().then(html => {
			form.outerHTML = html;
			document.addEventListener('turbo:load', () => {
				Promise.resolve().then( () =>{
					document.querySelector('.form-group-invalid .selectr-selected, input.is-invalid, select.is-invalid').focus();
				});
			}, {once: true});
			Turbo.dispatch('turbo:load');
		});
	});
}

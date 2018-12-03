export default function() {
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
				form.querySelectorAll('[type=submit]').forEach(el=>el.disabled = true);
				const token = document.querySelector('meta[name=csrf-token]').content;
				e.stopImmediatePropagation(); e.preventDefault();
				let body = new FormData(form);
				body.set('authenticity_token', token);
				fetch(form.action, {
					method: form.method, credentials: 'same-origin', redirect: 'manual',
					body: body
				}).then(res => {
					let url = res.redirected ? res.url : res.headers.get('location');
					if(url) {
						Turbolinks.visit(url);
						return;
					}
					res.text().then(html => {
						form.outerHTML = html;
						document.addEventListener('turbolinks:load', () => {
							Promise.resolve().then( () =>{
								document.querySelector('.form-group-invalid .selectr-selected, input.is-invalid, select.is-invalid').focus();
							});
						}, {once: true});
						Turbolinks.dispatch('turbolinks:load');
					});
				});
			});
		}
	}
}

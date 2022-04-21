import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	initialize() {
		this.element.onclick = this.click.bind(this);
	}

	click() {
		if (!this.modal) {
			this.render();
			Turbolinks.dispatch('turbolinks:load');
		}
		this.modal.addEventListener('click', e => {
			if (!this.modal.children[0].children[0].contains(e.target))
				window.dismissModal();
		});
		this.dismissOnEsc();
		this.show();
	}

	dismissOnEsc() {
		document.addEventListener('keydown', e => {
			if ( e.key === 'Escape' )
				window.dismissModal();
		});
	}

	show() {
		Array.from(this.modal.children).forEach( e => {
			e.style.display = 'block';
			setTimeout(()=>{e.classList.add('show')}, 0);
		});
	}

	render() {
		this.modal = document.createElement('div');
		this.modal.innerHTML = `
		<div class="modal fade" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">${this.data.get('title')}</h5>
		        <button type="button" class="close" onclick="dismissModal()" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>${this.data.get('body')}</p>
		      </div>
		      <div class="modal-footer">
		      	<form action="${this.data.get('url')}" method="post">
			        <button type="submit" class="btn btn-danger">${this.data.get('action')}</button>
		        </form>
		        <button type="button" class="btn btn-outline-secondary" onclick="dismissModal()">Ortga</button>
		      </div>
		    </div>
		  </div>
		</div>
		<div onclick="dismissModal()" class="modal-backdrop fade"></div>`;
		document.body.appendChild(this.modal);
	}

}
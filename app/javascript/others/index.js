import './icons';
import './alert';

document.addEventListener('turbolinks:load', function() {

    window.touch = "ontouchstart" in document.documentElement;
    let linkEventHandler = e => Turbolinks.visit(e.currentTarget.getAttribute('data-url'));
	let linkedEls = document.querySelectorAll('[data-url]');
	for (let i = 0; i < linkedEls.length; i++) {
		let event = (linkedEls[i].tagName === 'TR' && !window.touch) ? 'dblclick' : 'click';
		linkedEls[i].addEventListener(event, linkEventHandler);
	}

});

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
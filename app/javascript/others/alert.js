export default function() {
	clearTimeout(window.alertTimeOutCode);
	window.alertTimeOutCode = setTimeout(function() {
		let alert = document.getElementsByClassName('alert')[0];
		if (alert) {
			alert.classList.remove('alert-error','alert-danger','alert-success');
			alert.classList.add('border','rounded-0');
		}
	}, 4000);
}

window.dismiss = (e) => {
	e.currentTarget.parentElement.classList.add('hide');
};